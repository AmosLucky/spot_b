import 'dart:developer';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/data/models/hold_models.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/paid_invoice_list.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/summary.dart';
import 'package:spotstock_inventory/screens/desktop/pos/screens/desktop_pos_hold_sales_record.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/hold_model.dart';
import '../screens/table_view.dart';
import 'header.dart';
import 'invoices.dart';
import 'search_view.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;

  const Body({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController _barcodeController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ValueNotifier<String> _activeItem = ValueNotifier<String>("Dashboard");
  
  List _products = [];
  List<dynamic> warehouseData = [];
  List<dynamic> userAccessibleWarehouses = [];
  List _filterProducts = [];
  List _dataProducts = [];
  final bool _searching = false;
  bool _isInvoiceOpen = false;
  Map _registerInfo = {};
  List categoryData = [];
  List _productSearchResult = [];
  List _categoryResult = [];
  List? _foundProducts;
  int? tappedIndex;
  bool loadingProduct = false;
  String selectedCategory = '';
  String selectedAlphabetLetter = '';
  bool isLoadingWarehouses = false;
  Map<String, dynamic>? selectedBranch;
  Map? selectedTable;
  
  // Store current warehouse ID for proper filtering
  int? currentWarehouseId;
  List<int> userWarehouseIds = [];

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController();
    _parseUserWarehouseIds();
    readCategories();
    readProducts();
    readRegisterInfo();
    _filterByCategories();
    _productSearchResult = _products;
    _categoryResult = _products;
    _foundProducts = _productSearchResult;
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _audioPlayer.dispose();
    _activeItem.dispose();
    super.dispose();
  }

  void _parseUserWarehouseIds() {
    try {
      String? warehouseIdString = widget.user.warehouseId;
      if (warehouseIdString != null && warehouseIdString.isNotEmpty) {
        String cleanString = warehouseIdString.replaceAll('[', '').replaceAll(']', '');
        if (cleanString.isNotEmpty) {
          userWarehouseIds = cleanString
              .split(',')
              .map((id) => int.tryParse(id.trim()) ?? 0)
              .where((id) => id > 0)
              .toList();
        }
      }
      log("Parsed user warehouse IDs: $userWarehouseIds");
    } catch (e) {
      log("Error parsing user warehouse IDs: $e");
      userWarehouseIds = [];
    }
  }

  Future<void> playSound() async {
    await _audioPlayer.play(AssetSource('images/Heater-4_1.mp3'));
  }

  Future<void> readProducts() async {
    setState(() {
      loadingProduct = true;
    });
    try {
      await _fetchWarehouses(); // Fetch warehouses based on user role
      
      // **FIXED: Check if user has accessible warehouses before proceeding**
      if (userAccessibleWarehouses.isEmpty) {
        setState(() {
          _products = [];
          _dataProducts = [];
          loadingProduct = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No warehouses assigned to this user')),
        );
        return;
      }

      int warehouseId;
      if (widget.user.isSuperAdmin) {
        warehouseId = selectedBranch?['id'] ?? userAccessibleWarehouses[0]['id'];
      } else {
        warehouseId = selectedBranch?['id'] ?? userAccessibleWarehouses[0]['id'];
      }
      
      currentWarehouseId = warehouseId;
      await widget.systemProvider.fetchProducts(true, true, warehouseId);
      final data = await widget.systemProvider.getProducts(1);
      
      final warehouseFilteredProducts = data.where((product) {
        final productWarehouseId = product['attributes']['stock']['warehouse_id'];
        return productWarehouseId == warehouseId &&
            product['attributes']['stock']['quantity'] > 0;
      }).toList();

      setState(() {
        _products = warehouseFilteredProducts;
        _dataProducts = _products;
        loadingProduct = false;
      });
      
      log("Filtered products for warehouse $warehouseId: ${_products.length}");
      _filterByCategories();
    } catch (e) {
      setState(() {
        loadingProduct = false;
      });
      log("Error loading products: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading products')),
      );
    }
  }

  Future<void> _fetchWarehouses() async {
    try {
      List<dynamic> fetchedWarehouses = [];
      
      // **FIXED: Use the correct method calls and handle the response properly**
      if (widget.user.isStoreStaff || widget.user.isHotelStaff) {
        // For staff, try to get user-specific warehouses first
        try {
          fetchedWarehouses = await widget.systemProvider.getUserWarehouses();
          log("Fetched user-specific warehouses for staff: ${fetchedWarehouses.length}");
        } catch (e) {
          log("Error fetching user warehouses, falling back to general warehouses: $e");
          // Fallback to general warehouses if user-specific fails
          fetchedWarehouses = await widget.systemProvider.getWarehouse();
        }
      } else {
        // For admins and super admins, use the general warehouses endpoint
        fetchedWarehouses = await widget.systemProvider.getWarehouse();
        log("Fetched general warehouses for admin: ${fetchedWarehouses.length}");
      }

      setState(() {
        warehouseData = fetchedWarehouses;
        _filterUserAccessibleWarehouses();
      });
    } catch (e) {
      log("Error fetching warehouses: $e");
      // Fallback to existing warehouse data if available
      setState(() {
        _filterUserAccessibleWarehouses();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching warehouses: ${e.toString()}')),
      );
    }
  }

  void _filterUserAccessibleWarehouses() {
    if (widget.user.isSuperAdmin) {
      // Super admin can access all warehouses
      userAccessibleWarehouses = List.from(warehouseData);
      log("Super admin - accessible warehouses: ${userAccessibleWarehouses.length}");
    } else if (widget.user.isAdmin == 1) {
      // Admin can access all warehouses in their company
      userAccessibleWarehouses = List.from(warehouseData);
      log("Admin - accessible warehouses: ${userAccessibleWarehouses.length}");
    } else {
      // **FIXED: Staff members can only access warehouses they're assigned to**
      if (userWarehouseIds.isNotEmpty) {
        userAccessibleWarehouses = warehouseData.where((warehouse) {
          // Handle both API response formats
          int warehouseId = warehouse['id'] ?? warehouse['attributes']?['id'] ?? 0;
          return userWarehouseIds.contains(warehouseId);
        }).toList();
        log("Staff with assigned warehouses - accessible: ${userAccessibleWarehouses.length}");
      } else {
        // **FIXED: If no warehouses assigned, return empty list instead of all warehouses**
        userAccessibleWarehouses = [];
        log("Staff user has no warehouses assigned");
      }
    }
    
    // Log the accessible warehouse names for debugging
    final warehouseNames = userAccessibleWarehouses.map((w) {
      return w['attributes']?['name'] ?? w['name'] ?? 'Unknown';
    }).toList();
    log("User accessible warehouses: $warehouseNames");
  }

  bool _canAccessWarehouse(int warehouseId) {
    if (widget.user.isSuperAdmin) {
      return true;
    }
    if (widget.user.isAdmin == 1) {
      return true;
    }
    // **FIXED: Staff can only access warehouses they're assigned to**
    return userWarehouseIds.isNotEmpty && userWarehouseIds.contains(warehouseId);
  }

  Future<List<dynamic>> getProducts() async {
    var products = await widget.systemProvider.getProducts(0);
    if (currentWarehouseId != null) {
      products = products.where((product) =>
          product['attributes']['stock']['warehouse_id'] == currentWarehouseId &&
          product['attributes']['stock']['quantity'] > 0).toList();
    }
    return products;
  }

  Future<void> readRegisterInfo() async {
    final data = await widget.systemProvider.getCurrentRegister();
    print("---------current open register ----------");
    print(data);
    setState(() {
      _registerInfo = data;
    });
  }

  Future<void> readCategories() async {
    final data = await widget.systemProvider.getCategories();
    print("---------categories ----------");
    print(data);
    setState(() {
      categoryData = data;
    });
  }

  Future barcodeScan() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      String? barcode = "";
      if (barcode == "-1") {
        setState(() {
          barcode = '';
        });
        Dialogs.alertDialog(
            context, "Warning", "Nothing was found!", "cancel", "save", []);
      } else {
        setState(() {
          _barcodeController.text = barcode!;
        });
      }
    } else {
      Dialogs.alertDialog(
          context, "Error", "Camera permission denied!", "cancel", "save", []);
    }
  }

  // **NEW: Handle hold record retrieval**
  void _handleHoldRecordRetrieved(HoldRecord? holdRecord) {
    if (holdRecord != null) {
      // Process the retrieved hold record
      // Convert hold items to cart items and populate the POS
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      
      // Clear current cart
      cartProvider.removeAll(); // **FIXED: Use removeAll() instead of clearCart()
      
      // Add hold items to cart
      for (final holdItem in holdRecord.holdItems) {
        // Find the product in the current products list
        final product = _products.firstWhere(
          (p) => p['attributes']['stock']['product_id'] == holdItem.productId,
          orElse: () => null,
        );
        
        if (product != null) {
          cartProvider.add(
            product['attributes'],
            holdItem.productId,
            generateRandomStringForInvoice(12),
            holdItem.productPrice.toInt(), // **FIXED: Convert double to int
            holdItem.quantity,
            product['attributes']['product_code'],
          );
        }
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hold record "${holdRecord.referenceCode}" loaded successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: widget.mediaQuery.height,
                  ),
                  child: SideBarPos(
                    vertical: 10,
                    horizontal: 5,
                    user: widget.user,
                    mediaQuery: widget.mediaQuery,
                    systemProvider: widget.systemProvider,
                    activeItem: _activeItem,
                    openInvoice: () {
                      print("------------- open invoice -----------");
                      setState(() {
                        if (_registerInfo.isNotEmpty) {
                          _isInvoiceOpen = !_isInvoiceOpen;
                          selectedTable = null;
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 16.0),
                        child: HeaderSection(
                          systemProvider: widget.systemProvider,
                          mediaQuery: widget.mediaQuery,
                          user: widget.user,
                          controller: _barcodeController,
                          onChanged: (value) => _searchProducts(value),
                          onClearButtonPressed: () {
                            _barcodeController.clear();
                            setState(() {
                              _productSearchResult = _products;
                              _foundProducts = _productSearchResult;
                            });
                          },
                          onPressedScan: barcodeScan,
                          items: userAccessibleWarehouses,
                          selectedBranch: selectedBranch,
                          onBranchSelected: (value) async {
                            if (value == null) return;
                            
                            // Handle both API response formats for warehouse ID
                            int warehouseId = value['id'] ?? value['attributes']?['id'] ?? 0;
                            
                            if (!_canAccessWarehouse(warehouseId)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'You do not have access to this warehouse')),
                              );
                              return;
                            }

                            setState(() {
                              loadingProduct = true;
                              selectedBranch = value;
                              currentWarehouseId = warehouseId;
                            });

                            try {
                              await widget.systemProvider.fetchProducts(
                                  true, true, warehouseId);
                              final data =
                                  await widget.systemProvider.getProducts(1);

                              final warehouseFilteredProducts = data.where(
                                  (product) {
                                final productWarehouseId = product['attributes']
                                    ['stock']['warehouse_id'];
                                return productWarehouseId == warehouseId &&
                                    product['attributes']['stock']['quantity'] >
                                        0;
                              }).toList();

                              setState(() {
                                _products = warehouseFilteredProducts;
                                _dataProducts = _products;
                                loadingProduct = false;
                                selectedCategory = '';
                                selectedAlphabetLetter = '';
                              });

                              _filterByCategories();
                            } catch (e) {
                              setState(() {
                                loadingProduct = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Error loading products for warehouse')),
                              );
                            }
                          },
                          hint: _getWarehouseDisplayName(),
                        ),
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: _activeItem,
                        builder: (context, activeItem, child) {
                          if (activeItem == "Table") {
                            return TableView(
                              mediaQuery: widget.mediaQuery,
                              onTableSelected: (table) {
                                setState(() {
                                  selectedTable = table;
                                  _isInvoiceOpen = false;
                                });
                              },
                            );
                          }
                          
                          // **NEW: Handle Hold List Record navigation**
                          if (activeItem == "Hold List Record") {
                            return DesktopPosHoldSalesRecord(
                              user: widget.user,
                              systemProvider: widget.systemProvider,
                              mediaQuery: widget.mediaQuery,
                              activeItem: _activeItem,
                            );
                          }
                          
                          // **FIXED: Show message when no warehouses are available**
                          if (userAccessibleWarehouses.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warehouse_outlined,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No Warehouses Assigned',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please contact your administrator to assign warehouses to your account.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          
                          return Column(
                            children: [
                              // Alphabet Filter Row
                              Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedAlphabetLetter = '';
                                          selectedCategory = '';
                                        });
                                        _filterByCategories();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          color: selectedAlphabetLetter == '' &&
                                                  selectedCategory == ''
                                              ? Colors.deepPurple
                                              : Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(25),
                                          border: Border.all(
                                            color: selectedAlphabetLetter == '' &&
                                                    selectedCategory == ''
                                                ? Colors.deepPurple
                                                : Colors.grey.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Text(
                                          "ALL",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: selectedAlphabetLetter == '' &&
                                                    selectedCategory == ''
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(26, (index) {
                                            String letter =
                                                String.fromCharCode(65 + index);
                                            bool isSelected =
                                                selectedAlphabetLetter == letter;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedAlphabetLetter =
                                                      letter;
                                                  selectedCategory = '';
                                                });
                                                _filterByAlphabet(letter);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 14, vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.deepPurple
                                                      : Colors.grey.withOpacity(
                                                          0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: isSelected
                                                        ? Colors.deepPurple
                                                        : Colors.grey.withOpacity(
                                                            0.3),
                                                  ),
                                                  boxShadow: isSelected
                                                      ? [
                                                          BoxShadow(
                                                            color: Colors
                                                                .deepPurple
                                                                .withOpacity(0.3),
                                                            blurRadius: 4,
                                                            offset: Offset(0, 2),
                                                          )
                                                        ]
                                                      : null,
                                                ),
                                                child: Text(
                                                  letter,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Category Filter Row
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = '';
                                        selectedAlphabetLetter = '';
                                      });
                                      _filterByCategories();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selectedCategory == '' &&
                                                selectedAlphabetLetter == ''
                                            ? Colors.purple
                                            : Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "All",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: selectedCategory == '' &&
                                                  selectedAlphabetLetter == ''
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 1.w),
                                  Expanded(
                                    child: SizedBox(
                                      height: 12.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: GridView.count(
                                        shrinkWrap: false,
                                        crossAxisCount: 2,
                                        physics: const ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 0.4,
                                        padding: EdgeInsets.zero,
                                        children: categoryData.isEmpty
                                            ? [SizedBox()]
                                            : categoryData
                                                .map((cat) => GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedCategory =
                                                              cat['attributes']
                                                                  ['name'];
                                                          selectedAlphabetLetter =
                                                              '';
                                                        });
                                                        _filterByCategories();
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                          color: selectedCategory ==
                                                                  cat['attributes']
                                                                      ['name']
                                                              ? Colors.purple
                                                              : Colors.grey
                                                                  .withOpacity(
                                                                      0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            cat['attributes']
                                                                ['name'],
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: selectedCategory ==
                                                                      cat['attributes']
                                                                          ['name']
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toSet()
                                                .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.h),
                              SearchView(
                                tapInvoiceOpen: () {
                                  setState(() {
                                    _isInvoiceOpen = !_isInvoiceOpen;
                                    selectedTable = null;
                                  });
                                },
                                dataProducts: _foundProducts!,
                                getProducts: getProducts,
                                barcodeController: _barcodeController,
                                mediaQuery: widget.mediaQuery,
                                playSound: () => playSound(),
                              ),
                              _barcodeController.text.isEmpty &&
                                      !loadingProduct
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SizedBox(
                                        height: widget.mediaQuery.height - 50,
                                        child: GridView.builder(
                                          itemCount: _foundProducts!.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            childAspectRatio: 1.5,
                                          ),
                                          itemBuilder: (context, index) {
                                            var product = _foundProducts![index]
                                                ['attributes'];
                                            return Consumer<CartProvider>(
                                              builder: (context, value, child) =>
                                                  InkWell(
                                                onTap: () {
                                                  print("tapped");
                                                  tappedIndex = index;
                                                  if (product['stock']
                                                          ['quantity'] ==
                                                      0) {
                                                    Dialogs.alertDialog(
                                                        context,
                                                        "Warning",
                                                        "Product is out of stock!",
                                                        "cancel",
                                                        "save",
                                                        []);
                                                  } else {
                                                    if (_isInvoiceOpen) {
                                                      setState(() {
                                                        _isInvoiceOpen =
                                                            !_isInvoiceOpen;
                                                      });
                                                    }
                                                    value.add(
                                                        product,
                                                        index,
                                                        generateRandomStringForInvoice(
                                                            12),
                                                        product['product_price'],
                                                        1,
                                                        product['product_code']);
                                                    playSound();
                                                  }
                                                },
                                                child: ProductDetails(
                                                    product: product),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ValueListenableBuilder<String>(
                    valueListenable: _activeItem,
                    builder: (context, activeItem, child) {
                      if (activeItem == "Table" && selectedTable != null) {
                        return TableSummary(
                          selectedTable: selectedTable!,
                          mediaQuery: widget.mediaQuery,
                        );
                      } else if (_isInvoiceOpen && _registerInfo.isNotEmpty) {
                        return InvoiceList(
                          products: _products,
                          mediaQuery: widget.mediaQuery,
                          systemProvider: widget.systemProvider,
                          registerInfo: _registerInfo,
                          user: widget.user,
                          closeInvoice: () {
                            setState(() {
                              _isInvoiceOpen = !_isInvoiceOpen;
                              selectedTable = null;
                            });
                          },
                        );
                      } else if (activeItem == "Paid Invoices" &&
                          widget.user.isAnyAdmin) {
                        return PaidInvoicesList(
                          systemProvider: widget.systemProvider,
                          user: widget.user,
                          mediaQuery: widget.mediaQuery,
                        );
                      }
                      return OrderSummary(
                        products: _products,
                        mediaQuery: widget.mediaQuery,
                        registerInfo: _registerInfo,
                        systemProvider: widget.systemProvider,
                        user: widget.user,
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // **ADDED: Helper method to get warehouse display name**
  String _getWarehouseDisplayName() {
    if (selectedBranch != null) {
      return selectedBranch!['attributes']?['name'] ??
              selectedBranch!['name'] ??
              'Selected Warehouse';
    }
        
    if (userAccessibleWarehouses.isNotEmpty) {
      final firstWarehouse = userAccessibleWarehouses[0];
      return firstWarehouse['attributes']?['name'] ??
              firstWarehouse['name'] ??
              'Select Warehouse';
    }
        
    return "No Warehouse Available";
  }

  void _searchProducts(String? value) {
    print("Onchanged called");
    setState(() {
      selectedCategory = '';
      selectedAlphabetLetter = '';
      selectedTable = null;
    });

    if (_barcodeController.text.isEmpty) {
      setState(() {
        _productSearchResult = _products;
        _foundProducts = _productSearchResult;
      });
    } else {
      setState(() {
        if (_barcodeController.text.contains(RegExp('[a-zA-Z]'))) {
          _productSearchResult = _products.where((beneficiary) {
            return beneficiary['attributes']['name']
                .toLowerCase()
                .contains(_barcodeController.text.toLowerCase());
          }).toList();
          _foundProducts = _productSearchResult;
        } else {
          _productSearchResult = _products.where((beneficiary) {
            return beneficiary['attributes']['product_code']
                .toLowerCase()
                .contains(_barcodeController.text.toLowerCase());
          }).toList();
          _foundProducts = _productSearchResult;
        }
      });
    }
    debugPrint(_foundProducts.toString());
  }

  void _filterByCategories() {
    print("Filter by category");
    setState(() {
      selectedTable = null;
    });

    if (selectedCategory == '') {
      setState(() {
        _categoryResult = _products;
        _foundProducts = _categoryResult;
      });
    } else {
      setState(() {
        _categoryResult = _products.where((beneficiary) {
          return beneficiary['attributes']['product_category_name']
              .toLowerCase()
              .contains(selectedCategory.toLowerCase());
        }).toList();
        _foundProducts = _categoryResult;
      });
    }
    debugPrint("Category filtered products: ${_foundProducts!.length}");
  }

  void _filterByAlphabet(String letter) {
    print("Filter by alphabet: $letter");
    setState(() {
      selectedTable = null;
    });

    setState(() {
      _foundProducts = _products.where((product) {
        return product['attributes']['name']
            .toString()
            .toUpperCase()
            .startsWith(letter);
      }).toList();
    });
    debugPrint("Alphabet filtered products: ${_foundProducts!.length}");
  }
}

String generateRandomStringForInvoice(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(Iterable.generate(
      length,
      (_) =>
          chars.codeUnitAt((DateTime.now().millisecondsSinceEpoch % chars.length))));
}





// import 'dart:developer';
// import 'dart:convert';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:spotstock_inventory/common/provider/cart_provider.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/paid_invoice_list.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/summary.dart';
// import 'package:spotstock_inventory/widgets/dialogs.dart';
// import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import '../screens/table_view.dart';
// import 'header.dart';
// import 'invoices.dart';
// import 'search_view.dart';

// class Body extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final Size mediaQuery;

//   const Body({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     required this.mediaQuery,
//   });

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   late TextEditingController _barcodeController;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final ValueNotifier<String> _activeItem = ValueNotifier<String>("Dashboard");
  
//   List _products = [];
//   List<dynamic> warehouseData = [];
//   List<dynamic> userAccessibleWarehouses = [];
//   List _filterProducts = [];
//   List _dataProducts = [];
//   final bool _searching = false;
//   bool _isInvoiceOpen = false;
//   Map _registerInfo = {};
//   List categoryData = [];
//   List _productSearchResult = [];
//   List _categoryResult = [];
//   List? _foundProducts;
//   int? tappedIndex;
//   bool loadingProduct = false;
//   String selectedCategory = '';
//   String selectedAlphabetLetter = '';
//   bool isLoadingWarehouses = false;
//   Map<String, dynamic>? selectedBranch;
//   Map? selectedTable;
  
//   // Store current warehouse ID for proper filtering
//   int? currentWarehouseId;
//   List<int> userWarehouseIds = [];

//   @override
//   void initState() {
//     super.initState();
//     _barcodeController = TextEditingController();
//     _parseUserWarehouseIds();
//     readCategories();
//     readProducts();
//     readRegisterInfo();
//     _filterByCategories();
//     _productSearchResult = _products;
//     _categoryResult = _products;
//     _foundProducts = _productSearchResult;
//   }

//   @override
//   void dispose() {
//     _barcodeController.dispose();
//     _audioPlayer.dispose();
//     _activeItem.dispose();
//     super.dispose();
//   }

//   void _parseUserWarehouseIds() {
//     try {
//       String? warehouseIdString = widget.user.warehouseId;
//       if (warehouseIdString != null && warehouseIdString.isNotEmpty) {
//         String cleanString = warehouseIdString.replaceAll('[', '').replaceAll(']', '');
//         if (cleanString.isNotEmpty) {
//           userWarehouseIds = cleanString
//               .split(',')
//               .map((id) => int.tryParse(id.trim()) ?? 0)
//               .where((id) => id > 0)
//               .toList();
//         }
//       }
//       log("Parsed user warehouse IDs: $userWarehouseIds");
//     } catch (e) {
//       log("Error parsing user warehouse IDs: $e");
//       userWarehouseIds = [];
//     }
//   }

//   Future<void> playSound() async {
//     await _audioPlayer.play(AssetSource('images/Heater-4_1.mp3'));
//   }

//   Future<void> readProducts() async {
//     setState(() {
//       loadingProduct = true;
//     });
//     try {
//       await _fetchWarehouses(); // Fetch warehouses based on user role
      
//       // **FIXED: Check if user has accessible warehouses before proceeding**
//       if (userAccessibleWarehouses.isEmpty) {
//         setState(() {
//           _products = [];
//           _dataProducts = [];
//           loadingProduct = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No warehouses assigned to this user')),
//         );
//         return;
//       }

//       int warehouseId;
//       if (widget.user.isSuperAdmin) {
//         warehouseId = selectedBranch?['id'] ?? userAccessibleWarehouses[0]['id'];
//       } else {
//         warehouseId = selectedBranch?['id'] ?? userAccessibleWarehouses[0]['id'];
//       }
      
//       currentWarehouseId = warehouseId;
//       await widget.systemProvider.fetchProducts(true, true, warehouseId);
//       final data = await widget.systemProvider.getProducts(1);
      
//       final warehouseFilteredProducts = data.where((product) {
//         final productWarehouseId = product['attributes']['stock']['warehouse_id'];
//         return productWarehouseId == warehouseId &&
//             product['attributes']['stock']['quantity'] > 0;
//       }).toList();

//       setState(() {
//         _products = warehouseFilteredProducts;
//         _dataProducts = _products;
//         loadingProduct = false;
//       });
      
//       log("Filtered products for warehouse $warehouseId: ${_products.length}");
//       _filterByCategories();
//     } catch (e) {
//       setState(() {
//         loadingProduct = false;
//       });
//       log("Error loading products: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading products')),
//       );
//     }
//   }

//   Future<void> _fetchWarehouses() async {
//     try {
//       List<dynamic> fetchedWarehouses = [];
      
//       // **FIXED: Use the correct method calls and handle the response properly**
//       if (widget.user.isStoreStaff || widget.user.isHotelStaff) {
//         // For staff, try to get user-specific warehouses first
//         try {
//           fetchedWarehouses = await widget.systemProvider.getUserWarehouses();
//           log("Fetched user-specific warehouses for staff: ${fetchedWarehouses.length}");
//         } catch (e) {
//           log("Error fetching user warehouses, falling back to general warehouses: $e");
//           // Fallback to general warehouses if user-specific fails
//           fetchedWarehouses = await widget.systemProvider.getWarehouse();
//         }
//       } else {
//         // For admins and super admins, use the general warehouses endpoint
//         fetchedWarehouses = await widget.systemProvider.getWarehouse();
//         log("Fetched general warehouses for admin: ${fetchedWarehouses.length}");
//       }

//       setState(() {
//         warehouseData = fetchedWarehouses;
//         _filterUserAccessibleWarehouses();
//       });
//     } catch (e) {
//       log("Error fetching warehouses: $e");
//       // Fallback to existing warehouse data if available
//       setState(() {
//         _filterUserAccessibleWarehouses();
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching warehouses: ${e.toString()}')),
//       );
//     }
//   }

//   void _filterUserAccessibleWarehouses() {
//     if (widget.user.isSuperAdmin) {
//       // Super admin can access all warehouses
//       userAccessibleWarehouses = List.from(warehouseData);
//       log("Super admin - accessible warehouses: ${userAccessibleWarehouses.length}");
//     } else if (widget.user.isAdmin == 1) {
//       // Admin can access all warehouses in their company
//       userAccessibleWarehouses = List.from(warehouseData);
//       log("Admin - accessible warehouses: ${userAccessibleWarehouses.length}");
//     } else {
//       // **FIXED: Staff members can only access warehouses they're assigned to**
//       if (userWarehouseIds.isNotEmpty) {
//         userAccessibleWarehouses = warehouseData.where((warehouse) {
//           // Handle both API response formats
//           int warehouseId = warehouse['id'] ?? warehouse['attributes']?['id'] ?? 0;
//           return userWarehouseIds.contains(warehouseId);
//         }).toList();
//         log("Staff with assigned warehouses - accessible: ${userAccessibleWarehouses.length}");
//       } else {
//         // **FIXED: If no warehouses assigned, return empty list instead of all warehouses**
//         userAccessibleWarehouses = [];
//         log("Staff user has no warehouses assigned");
//       }
//     }
    
//     // Log the accessible warehouse names for debugging
//     final warehouseNames = userAccessibleWarehouses.map((w) {
//       return w['attributes']?['name'] ?? w['name'] ?? 'Unknown';
//     }).toList();
//     log("User accessible warehouses: $warehouseNames");
//   }

//   bool _canAccessWarehouse(int warehouseId) {
//     if (widget.user.isSuperAdmin) {
//       return true;
//     }
//     if (widget.user.isAdmin == 1) {
//       return true;
//     }
//     // **FIXED: Staff can only access warehouses they're assigned to**
//     return userWarehouseIds.isNotEmpty && userWarehouseIds.contains(warehouseId);
//   }

//   Future<List<dynamic>> getProducts() async {
//     var products = await widget.systemProvider.getProducts(0);
//     if (currentWarehouseId != null) {
//       products = products.where((product) =>
//           product['attributes']['stock']['warehouse_id'] == currentWarehouseId &&
//           product['attributes']['stock']['quantity'] > 0).toList();
//     }
//     return products;
//   }

//   Future<void> readRegisterInfo() async {
//     final data = await widget.systemProvider.getCurrentRegister();
//     print("---------current open register ----------");
//     print(data);
//     setState(() {
//       _registerInfo = data;
//     });
//   }

//   Future<void> readCategories() async {
//     final data = await widget.systemProvider.getCategories();
//     print("---------categories ----------");
//     print(data);
//     setState(() {
//       categoryData = data;
//     });
//   }

//   Future barcodeScan() async {
//     var status = await Permission.camera.status;
//     if (!status.isGranted) {
//       status = await Permission.camera.request();
//     }
//     if (status.isGranted) {
//       String? barcode = "";
//       if (barcode == "-1") {
//         setState(() {
//           barcode = '';
//         });
//         Dialogs.alertDialog(
//             context, "Warning", "Nothing was found!", "cancel", "save", []);
//       } else {
//         setState(() {
//           _barcodeController.text = barcode!;
//         });
//       }
//     } else {
//       Dialogs.alertDialog(
//           context, "Error", "Camera permission denied!", "cancel", "save", []);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: widget.mediaQuery.height,
//                   ),
//                   child: SideBarPos(
//                     vertical: 10,
//                     horizontal: 5,
//                     user: widget.user,
//                     mediaQuery: widget.mediaQuery,
//                     systemProvider: widget.systemProvider,
//                     activeItem: _activeItem,
//                     openInvoice: () {
//                       print("------------- open invoice -----------");
//                       setState(() {
//                         if (_registerInfo.isNotEmpty) {
//                           _isInvoiceOpen = !_isInvoiceOpen;
//                           selectedTable = null;
//                         }
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 3.0, horizontal: 16.0),
//                         child: HeaderSection(
//                           systemProvider: widget.systemProvider,
//                           mediaQuery: widget.mediaQuery,
//                           user: widget.user,
//                           controller: _barcodeController,
//                           onChanged: (value) => _searchProducts(value),
//                           onClearButtonPressed: () {
//                             _barcodeController.clear();
//                             setState(() {
//                               _productSearchResult = _products;
//                               _foundProducts = _productSearchResult;
//                             });
//                           },
//                           onPressedScan: barcodeScan,
//                           items: userAccessibleWarehouses,
//                           selectedBranch: selectedBranch,
//                           onBranchSelected: (value) async {
//                             if (value == null) return;
                            
//                             // Handle both API response formats for warehouse ID
//                             int warehouseId = value['id'] ?? value['attributes']?['id'] ?? 0;
                            
//                             if (!_canAccessWarehouse(warehouseId)) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text(
//                                         'You do not have access to this warehouse')),
//                               );
//                               return;
//                             }
//                             setState(() {
//                               loadingProduct = true;
//                               selectedBranch = value;
//                               currentWarehouseId = warehouseId;
//                             });
//                             try {
//                               await widget.systemProvider.fetchProducts(
//                                   true, true, warehouseId);
//                               final data =
//                                   await widget.systemProvider.getProducts(1);
//                               final warehouseFilteredProducts = data.where(
//                                   (product) {
//                                 final productWarehouseId = product['attributes']
//                                     ['stock']['warehouse_id'];
//                                 return productWarehouseId == warehouseId &&
//                                     product['attributes']['stock']['quantity'] >
//                                         0;
//                               }).toList();
//                               setState(() {
//                                 _products = warehouseFilteredProducts;
//                                 _dataProducts = _products;
//                                 loadingProduct = false;
//                                 selectedCategory = '';
//                                 selectedAlphabetLetter = '';
//                               });
//                               _filterByCategories();
//                             } catch (e) {
//                               setState(() {
//                                 loadingProduct = false;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text(
//                                         'Error loading products for warehouse')),
//                               );
//                             }
//                           },
//                           hint: _getWarehouseDisplayName(),
//                         ),
//                       ),
//                       ValueListenableBuilder<String>(
//                         valueListenable: _activeItem,
//                         builder: (context, activeItem, child) {
//                           if (activeItem == "Table") {
//                             return TableView(
//                               mediaQuery: widget.mediaQuery,
//                               onTableSelected: (table) {
//                                 setState(() {
//                                   selectedTable = table;
//                                   _isInvoiceOpen = false;
//                                 });
//                               },
//                             );
//                           }
                          
//                           // **FIXED: Show message when no warehouses are available**
//                           if (userAccessibleWarehouses.isEmpty) {
//                             return Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.warehouse_outlined,
//                                       size: 64,
//                                       color: Colors.grey,
//                                     ),
//                                     SizedBox(height: 16),
//                                     Text(
//                                       'No Warehouses Assigned',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.grey[700],
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       'Please contact your administrator to assign warehouses to your account.',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey[600],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }
                          
//                           return Column(
//                             children: [
//                               // Alphabet Filter Row
//                               Container(
//                                 height: 60,
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 8),
//                                 child: Row(
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedAlphabetLetter = '';
//                                           selectedCategory = '';
//                                         });
//                                         _filterByCategories();
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 8),
//                                         margin: EdgeInsets.only(right: 8),
//                                         decoration: BoxDecoration(
//                                           color: selectedAlphabetLetter == '' &&
//                                                   selectedCategory == ''
//                                               ? Colors.deepPurple
//                                               : Colors.grey.withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(25),
//                                           border: Border.all(
//                                             color: selectedAlphabetLetter == '' &&
//                                                     selectedCategory == ''
//                                                 ? Colors.deepPurple
//                                                 : Colors.grey.withOpacity(0.3),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "ALL",
//                                           style: TextStyle(
//                                             fontSize: 12.sp,
//                                             fontWeight: FontWeight.w600,
//                                             color: selectedAlphabetLetter == '' &&
//                                                     selectedCategory == ''
//                                                 ? Colors.white
//                                                 : Colors.black87,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: SingleChildScrollView(
//                                         scrollDirection: Axis.horizontal,
//                                         child: Row(
//                                           children: List.generate(26, (index) {
//                                             String letter =
//                                                 String.fromCharCode(65 + index);
//                                             bool isSelected =
//                                                 selectedAlphabetLetter == letter;
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   selectedAlphabetLetter =
//                                                       letter;
//                                                   selectedCategory = '';
//                                                 });
//                                                 _filterByAlphabet(letter);
//                                               },
//                                               child: Container(
//                                                 margin: EdgeInsets.symmetric(
//                                                     horizontal: 4),
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 14, vertical: 8),
//                                                 decoration: BoxDecoration(
//                                                   color: isSelected
//                                                       ? Colors.deepPurple
//                                                       : Colors.grey.withOpacity(
//                                                           0.1),
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   border: Border.all(
//                                                     color: isSelected
//                                                         ? Colors.deepPurple
//                                                         : Colors.grey.withOpacity(
//                                                             0.3),
//                                                   ),
//                                                   boxShadow: isSelected
//                                                       ? [
//                                                           BoxShadow(
//                                                             color: Colors
//                                                                 .deepPurple
//                                                                 .withOpacity(0.3),
//                                                             blurRadius: 4,
//                                                             offset: Offset(0, 2),
//                                                           )
//                                                         ]
//                                                       : null,
//                                                 ),
//                                                 child: Text(
//                                                   letter,
//                                                   style: TextStyle(
//                                                     fontSize: 11.sp,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: isSelected
//                                                         ? Colors.white
//                                                         : Colors.black87,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // Category Filter Row
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         selectedCategory = '';
//                                         selectedAlphabetLetter = '';
//                                       });
//                                       _filterByCategories();
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 20, vertical: 10),
//                                       decoration: BoxDecoration(
//                                         color: selectedCategory == '' &&
//                                                 selectedAlphabetLetter == ''
//                                             ? Colors.purple
//                                             : Colors.grey.withOpacity(0.1),
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Text(
//                                         "All",
//                                         style: TextStyle(
//                                           fontSize: 10.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: selectedCategory == '' &&
//                                                   selectedAlphabetLetter == ''
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 1.w),
//                                   Expanded(
//                                     child: SizedBox(
//                                       height: 12.h,
//                                       width: MediaQuery.of(context).size.width,
//                                       child: GridView.count(
//                                         shrinkWrap: false,
//                                         crossAxisCount: 2,
//                                         physics: const ClampingScrollPhysics(),
//                                         scrollDirection: Axis.horizontal,
//                                         crossAxisSpacing: 10,
//                                         mainAxisSpacing: 20,
//                                         childAspectRatio: 0.4,
//                                         padding: EdgeInsets.zero,
//                                         children: categoryData.isEmpty
//                                             ? [SizedBox()]
//                                             : categoryData
//                                                 .map((cat) => GestureDetector(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           selectedCategory =
//                                                               cat['attributes']
//                                                                   ['name'];
//                                                           selectedAlphabetLetter =
//                                                               '';
//                                                         });
//                                                         _filterByCategories();
//                                                       },
//                                                       child: Container(
//                                                         padding: EdgeInsets.symmetric(
//                                                             horizontal: 10,
//                                                             vertical: 5),
//                                                         decoration: BoxDecoration(
//                                                           color: selectedCategory ==
//                                                                   cat['attributes']
//                                                                       ['name']
//                                                               ? Colors.purple
//                                                               : Colors.grey
//                                                                   .withOpacity(
//                                                                       0.1),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                         ),
//                                                         child: Center(
//                                                           child: Text(
//                                                             cat['attributes']
//                                                                 ['name'],
//                                                             style: TextStyle(
//                                                               fontSize: 10.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               color: selectedCategory ==
//                                                                       cat['attributes']
//                                                                           ['name']
//                                                                   ? Colors.white
//                                                                   : Colors.black,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ))
//                                                 .toSet()
//                                                 .toList(),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 1.h),
//                               SearchView(
//                                 tapInvoiceOpen: () {
//                                   setState(() {
//                                     _isInvoiceOpen = !_isInvoiceOpen;
//                                     selectedTable = null;
//                                   });
//                                 },
//                                 dataProducts: _foundProducts!,
//                                 getProducts: getProducts,
//                                 barcodeController: _barcodeController,
//                                 mediaQuery: widget.mediaQuery,
//                                 playSound: () => playSound(),
//                               ),
//                               _barcodeController.text.isEmpty &&
//                                       !loadingProduct
//                                   ? Padding(
//                                       padding: const EdgeInsets.all(16.0),
//                                       child: SizedBox(
//                                         height: widget.mediaQuery.height - 50,
//                                         child: GridView.builder(
//                                           itemCount: _foundProducts!.length,
//                                           gridDelegate:
//                                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 4,
//                                             crossAxisSpacing: 16,
//                                             mainAxisSpacing: 16,
//                                             childAspectRatio: 1.5,
//                                           ),
//                                           itemBuilder: (context, index) {
//                                             var product = _foundProducts![index]
//                                                 ['attributes'];
//                                             return Consumer<CartProvider>(
//                                               builder: (context, value, child) =>
//                                                   InkWell(
//                                                 onTap: () {
//                                                   print("tapped");
//                                                   tappedIndex = index;
//                                                   if (product['stock']
//                                                           ['quantity'] ==
//                                                       0) {
//                                                     Dialogs.alertDialog(
//                                                         context,
//                                                         "Warning",
//                                                         "Product is out of stock!",
//                                                         "cancel",
//                                                         "save",
//                                                         []);
//                                                   } else {
//                                                     if (_isInvoiceOpen) {
//                                                       setState(() {
//                                                         _isInvoiceOpen =
//                                                             !_isInvoiceOpen;
//                                                       });
//                                                     }
//                                                     value.add(
//                                                         product,
//                                                         index,
//                                                         generateRandomStringForInvoice(
//                                                             12),
//                                                         product['product_price'],
//                                                         1,
//                                                         product['product_code']);
//                                                     playSound();
//                                                   }
//                                                 },
//                                                 child: ProductDetails(
//                                                     product: product),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     )
//                                   : Padding(
//                                       padding: const EdgeInsets.only(top: 30),
//                                       child: Center(
//                                           child: CircularProgressIndicator()),
//                                     ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   child: ValueListenableBuilder<String>(
//                     valueListenable: _activeItem,
//                     builder: (context, activeItem, child) {
//                       if (activeItem == "Table" && selectedTable != null) {
//                         return TableSummary(
//                           selectedTable: selectedTable!,
//                           mediaQuery: widget.mediaQuery,
//                         );
//                       } else if (_isInvoiceOpen && _registerInfo.isNotEmpty) {
//                         return InvoiceList(
//                           products: _products,
//                           mediaQuery: widget.mediaQuery,
//                           systemProvider: widget.systemProvider,
//                           registerInfo: _registerInfo,
//                           user: widget.user,
//                           closeInvoice: () {
//                             setState(() {
//                               _isInvoiceOpen = !_isInvoiceOpen;
//                               selectedTable = null;
//                             });
//                           },
//                         );
//                       } else if (activeItem == "Paid Invoices" &&
//                           widget.user.isAnyAdmin) {
//                         return PaidInvoicesList(
//                           systemProvider: widget.systemProvider,
//                           user: widget.user,
//                           mediaQuery: widget.mediaQuery,
//                         );
//                       }
//                       return OrderSummary(
//                         products: _products,
//                         mediaQuery: widget.mediaQuery,
//                         registerInfo: _registerInfo,
//                         systemProvider: widget.systemProvider,
//                         user: widget.user,
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // **ADDED: Helper method to get warehouse display name**
//   String _getWarehouseDisplayName() {
//     if (selectedBranch != null) {
//       return selectedBranch!['attributes']?['name'] ?? 
//              selectedBranch!['name'] ?? 
//              'Selected Warehouse';
//     }
    
//     if (userAccessibleWarehouses.isNotEmpty) {
//       final firstWarehouse = userAccessibleWarehouses[0];
//       return firstWarehouse['attributes']?['name'] ?? 
//              firstWarehouse['name'] ?? 
//              'Select Warehouse';
//     }
    
//     return "No Warehouse Available";
//   }

//   void _searchProducts(String? value) {
//     print("Onchanged called");
//     setState(() {
//       selectedCategory = '';
//       selectedAlphabetLetter = '';
//       selectedTable = null;
//     });
//     if (_barcodeController.text.isEmpty) {
//       setState(() {
//         _productSearchResult = _products;
//         _foundProducts = _productSearchResult;
//       });
//     } else {
//       setState(() {
//         if (_barcodeController.text.contains(RegExp('[a-zA-Z]'))) {
//           _productSearchResult = _products.where((beneficiary) {
//             return beneficiary['attributes']['name']
//                 .toLowerCase()
//                 .contains(_barcodeController.text.toLowerCase());
//           }).toList();
//           _foundProducts = _productSearchResult;
//         } else {
//           _productSearchResult = _products.where((beneficiary) {
//             return beneficiary['attributes']['product_code']
//                 .toLowerCase()
//                 .contains(_barcodeController.text.toLowerCase());
//           }).toList();
//           _foundProducts = _productSearchResult;
//         }
//       });
//     }
//     debugPrint(_foundProducts.toString());
//   }

//   void _filterByCategories() {
//     print("Filter by category");
//     setState(() {
//       selectedTable = null;
//     });
//     if (selectedCategory == '') {
//       setState(() {
//         _categoryResult = _products;
//         _foundProducts = _categoryResult;
//       });
//     } else {
//       setState(() {
//         _categoryResult = _products.where((beneficiary) {
//           return beneficiary['attributes']['product_category_name']
//               .toLowerCase()
//               .contains(selectedCategory.toLowerCase());
//         }).toList();
//         _foundProducts = _categoryResult;
//       });
//     }
//     debugPrint("Category filtered products: ${_foundProducts!.length}");
//   }

//   void _filterByAlphabet(String letter) {
//     print("Filter by alphabet: $letter");
//     setState(() {
//       selectedTable = null;
//     });
//     setState(() {
//       _foundProducts = _products.where((product) {
//         return product['attributes']['name']
//             .toString()
//             .toUpperCase()
//             .startsWith(letter);
//       }).toList();
//     });
//     debugPrint("Alphabet filtered products: ${_foundProducts!.length}");
//   }
// }

// String generateRandomStringForInvoice(int length) {
//   const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//   return String.fromCharCodes(Iterable.generate(
//       length,
//       (_) =>
//           chars.codeUnitAt((DateTime.now().millisecondsSinceEpoch % chars.length))));
// }