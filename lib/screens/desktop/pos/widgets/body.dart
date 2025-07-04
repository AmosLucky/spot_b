import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/body.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/summary.dart';
import 'package:spotstock_inventory/widgets/custom_widgets.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../screens/table_view.dart';
import 'header.dart';
import 'invoices.dart';
import 'search_view.dart';
// import 'table_view.dart';

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
  bool isLoadingWarehouses = false;
  Map<String, dynamic>? selectedBranch;
  Map? selectedTable;

  final List<Map<String, dynamic>> branches = [
    {"label": "Branch 1", "id": "15"},
    {"label": "sdfd", "id": "27"}
  ];

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController();
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

  Future<void> playSound() async {
    await _audioPlayer.play(AssetSource('images/Heater-4_1.mp3'));
  }

  Future<void> readProducts() async {
    setState(() {
      loadingProduct = true;
    });

    try {
      warehouseData = await widget.systemProvider.getWarehouse();
      log("Warehouse data ==>> $warehouseData");

      if (warehouseData.isNotEmpty) {
        final warehouseId = selectedBranch?['id'] ?? warehouseData[0]['id'];
        await widget.systemProvider.fetchProducts(true, true, warehouseId);
        final data = await widget.systemProvider.getProducts(1);

        setState(() {
          _products = data.where((product) => 
              product['attributes']['stock']['quantity'] > 0).toList();
          _dataProducts = _products;
          loadingProduct = false;
        });

        log("Product data ==>> $data");
        _filterByCategories();
      } else {
        setState(() {
          loadingProduct = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No warehouses available')),
        );
      }
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

  Future<List<dynamic>> getProducts() async {
    var products = await widget.systemProvider.getProducts(0);
    return products.where((product) => 
        product['attributes']['stock']['quantity'] > 0).toList();
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
    print("---------current open register ----------");
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
                          selectedTable = null; // Reset table selection
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
                          items: warehouseData,
                          selectedBranch: selectedBranch,
                          onBranchSelected: (value) async {
                            if (value == null) return;

                            setState(() {
                              loadingProduct = true;
                              selectedBranch = value;
                            });

                            try {
                              await widget.systemProvider
                                  .fetchProducts(true, true, value['id']);
                              final data =
                                  await widget.systemProvider.getProducts(1);
                              setState(() {
                                _products = data.where((product) => 
                                    product['attributes']['stock']['quantity'] > 0).toList();
                                _dataProducts = _products;
                                loadingProduct = false;
                              });
                            } catch (e) {
                              setState(() {
                                loadingProduct = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Error loading products for branch')),
                              );
                            }
                          },
                          hint: selectedBranch?['attributes']['name'] ??
                              (warehouseData.isNotEmpty
                                  ? warehouseData[0]['attributes']['name']
                                  : "Select Branch"),
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
                                  _isInvoiceOpen = false; // Ensure invoice is closed
                                });
                              },
                            );
                          }
                          return Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = '';
                                      });
                                      print(selectedCategory);
                                      _filterByCategories();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: selectedCategory == ''
                                              ? Colors.purple
                                              : Colors.grey.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "All",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color: selectedCategory == ''
                                                ? Colors.white
                                                : Colors.black),
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
                                                          selectedCategory = cat[
                                                                  'attributes']
                                                              ['name'];
                                                        });
                                                        print(selectedCategory);
                                                        _filterByCategories();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
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
                                                                  FontWeight.w500,
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
                                    selectedTable = null; // Reset table selection
                                  });
                                },
                                dataProducts: _foundProducts!,
                                getProducts: getProducts,
                                barcodeController: _barcodeController,
                                mediaQuery: widget.mediaQuery,
                                playSound: () => playSound(),
                              ),
                              _barcodeController.text.isEmpty && !loadingProduct
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
                                                  print(
                                                      "Selected index === $index");
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
                                                        generateRandomString(12),
                                                        product[
                                                            'product_price'],
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10),
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
                            print("------------- close invoice -----------");
                            setState(() {
                              _isInvoiceOpen = !_isInvoiceOpen;
                              selectedTable = null; // Reset table selection
                            });
                          },
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

  void _searchProducts(String? value) {
    print("Onchanged called");
    setState(() {
      selectedCategory = '';
      selectedTable = null; // Reset table selection when searching
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
      selectedTable = null; // Reset table selection when filtering
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
    debugPrint(_foundProducts.toString());
  }
}




// import 'dart:developer';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:spotstock_inventory/common/provider/cart_provider.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/screens/desktop/home/widgets/body.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/product_detail.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/summary.dart';
// import 'package:spotstock_inventory/widgets/custom_widgets.dart';
// import 'package:spotstock_inventory/widgets/dialogs.dart';
// import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import '../screens/table_view.dart';
// import 'header.dart';
// import 'invoices.dart';
// import 'search_view.dart';
// // import 'table_view.dart';

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
//   bool isLoadingWarehouses = false;
//   Map<String, dynamic>? selectedBranch;
//   Map? selectedTable;

//   final List<Map<String, dynamic>> branches = [
//     {"label": "Branch 1", "id": "15"},
//     {"label": "sdfd", "id": "27"}
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _barcodeController = TextEditingController();
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

//   Future<void> playSound() async {
//     await _audioPlayer.play(AssetSource('images/Heater-4_1.mp3'));
//   }

//   Future<void> readProducts() async {
//     setState(() {
//       loadingProduct = true;
//     });

//     try {
//       warehouseData = await widget.systemProvider.getWarehouse();
//       log("Warehouse data ==>> $warehouseData");

//       if (warehouseData.isNotEmpty) {
//         final warehouseId = selectedBranch?['id'] ?? warehouseData[0]['id'];
//         await widget.systemProvider.fetchProducts(true, true, warehouseId);
//         final data = await widget.systemProvider.getProducts(1);

//         setState(() {
//           _products = data.where((product) => 
//               product['attributes']['stock']['quantity'] > 0).toList();
//           _dataProducts = _products;
//           loadingProduct = false;
//         });

//         log("Product data ==>> $data");
//         _filterByCategories();
//       } else {
//         setState(() {
//           loadingProduct = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No warehouses available')),
//         );
//       }
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

//   Future<List<dynamic>> getProducts() async {
//     var products = await widget.systemProvider.getProducts(0);
//     return products.where((product) => 
//         product['attributes']['stock']['quantity'] > 0).toList();
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
//     print("---------current open register ----------");
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
//                           items: warehouseData,
//                           selectedBranch: selectedBranch,
//                           onBranchSelected: (value) async {
//                             if (value == null) return;

//                             setState(() {
//                               loadingProduct = true;
//                               selectedBranch = value;
//                             });

//                             try {
//                               await widget.systemProvider
//                                   .fetchProducts(true, true, value['id']);
//                               final data =
//                                   await widget.systemProvider.getProducts(1);
//                               setState(() {
//                                 _products = data.where((product) => 
//                                     product['attributes']['stock']['quantity'] > 0).toList();
//                                 _dataProducts = _products;
//                                 loadingProduct = false;
//                               });
//                             } catch (e) {
//                               setState(() {
//                                 loadingProduct = false;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                         Text('Error loading products for branch')),
//                               );
//                             }
//                           },
//                           hint: selectedBranch?['attributes']['name'] ??
//                               (warehouseData.isNotEmpty
//                                   ? warehouseData[0]['attributes']['name']
//                                   : "Select Branch"),
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
//                                 });
//                               },
//                             );
//                           }
//                           return Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         selectedCategory = '';
//                                       });
//                                       print(selectedCategory);
//                                       _filterByCategories();
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 20, vertical: 10),
//                                       decoration: BoxDecoration(
//                                           color: selectedCategory == ''
//                                               ? Colors.purple
//                                               : Colors.grey.withOpacity(0.1),
//                                           borderRadius:
//                                               BorderRadius.circular(10)),
//                                       child: Text(
//                                         "All",
//                                         style: TextStyle(
//                                             fontSize: 10.sp,
//                                             fontWeight: FontWeight.w500,
//                                             color: selectedCategory == ''
//                                                 ? Colors.white
//                                                 : Colors.black),
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
//                                                           selectedCategory = cat[
//                                                                   'attributes']
//                                                               ['name'];
//                                                         });
//                                                         print(selectedCategory);
//                                                         _filterByCategories();
//                                                       },
//                                                       child: Container(
//                                                         padding:
//                                                             EdgeInsets.symmetric(
//                                                                 horizontal: 10,
//                                                                 vertical: 5),
//                                                         decoration:
//                                                             BoxDecoration(
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
//                                                                   FontWeight.w500,
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
//                                   });
//                                 },
//                                 dataProducts: _foundProducts!,
//                                 getProducts: getProducts,
//                                 barcodeController: _barcodeController,
//                                 mediaQuery: widget.mediaQuery,
//                                 playSound: () => playSound(),
//                               ),
//                               _barcodeController.text.isEmpty && !loadingProduct
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
//                                                   print(
//                                                       "Selected index === $index");
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
//                                                         generateRandomString(12),
//                                                         product[
//                                                             'product_price'],
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
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 10, horizontal: 10),
//                   child: ValueListenableBuilder<String>(
//                     valueListenable: _activeItem,
//                     builder: (context, activeItem, child) {
//                       if (activeItem == "Table" && selectedTable != null) {
//                         return TableSummary(
//                           selectedTable: selectedTable!,
//                           mediaQuery: widget.mediaQuery,
//                         );
//                       }
//                       return _isInvoiceOpen && _registerInfo.isNotEmpty
//                           ? InvoiceList(
//                               products: _products,
//                               mediaQuery: widget.mediaQuery,
//                               systemProvider: widget.systemProvider,
//                               registerInfo: _registerInfo,
//                               user: widget.user,
//                               closeInvoice: () {
//                                 print("------------- close invoice -----------");
//                                 setState(() {
//                                   if (_registerInfo.isNotEmpty) {
//                                     _isInvoiceOpen = !_isInvoiceOpen;
//                                   }
//                                 });
//                               })
//                           : OrderSummary(
//                               products: _products,
//                               mediaQuery: widget.mediaQuery,
//                               registerInfo: _registerInfo,
//                               systemProvider: widget.systemProvider,
//                               user: widget.user,
//                             );
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

//   void _searchProducts(String? value) {
//     print("Onchanged called");
//     setState(() {
//       selectedCategory = '';
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
//     debugPrint(_foundProducts.toString());
//   }
// }