import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_scanner_devxhub/flutter_scanner_devxhub.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/primary_text_field.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../common/custom_selector_sheet3.dart';
import '../../../common/secondary_custom_dropdown.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/responsive.dart';
import '../../desktop/home/widgets/body.dart';
import 'cart_mobile.dart';
import 'cart_summary.dart';

class EcosystemMobile2Screen extends StatefulWidget {
  final SystemProvider systemProvider;
  final Map<String, dynamic> category;
  final int? id;

  const EcosystemMobile2Screen(
      {super.key,
      required this.systemProvider,
      required this.category,
      this.id = 0});

  @override
  State<EcosystemMobile2Screen> createState() => _EcosystemMobile2ScreenState();
}

List _products = [];
List warehouseData = [];
List _filterProducts = [];
List _dataProducts = [];
List _productSearchResult = [];
List? _foundProducts;
bool _searching = false;
bool loadingProduct = false;
Map?  selectedBranch;
String selectedCategory = '';
List _categoryResult = [];
List categoryData = [];

final List<Map<String, dynamic>> branches = [
  {"label" : "Branch 1", "id" : "15"},
  {"label" : "sdfd", "id" : "27"}
];

class _EcosystemMobile2ScreenState extends State<EcosystemMobile2Screen> {
  TextEditingController? _barcodeController;

  @override
  void initState() {
    super.initState();
    //initBarCodeScanner();
    _barcodeController = TextEditingController(
        text: widget.category['id'] == 0 ? '' : widget.category['name']);
    readCategories();
    readProducts();
    _filterByCategories();
    _productSearchResult = _products;
    _categoryResult = _products;
    _foundProducts = _productSearchResult;
  }

  // void initBarCodeScanner() async {
  //   await zx.startCameraProcessing();
  // }

  Future<List<dynamic>> getProducts() async {
    return await widget.systemProvider.getProducts(widget.category['id']);
  }

  // Future<void> readProducts() async {
  //   print(widget.category);
  //   final data = await widget.systemProvider.getProducts(widget.category['id']);
  //   setState(() {
  //     _products = data;
  //     _dataProducts = data;
  //   });
  // }

  Future<void> readProducts() async {
    setState(() {
      loadingProduct = true;
    });
    final data = await widget.systemProvider.getProducts(1);
    await widget.systemProvider.getWarehouse().then((value) async {
      log("Warehouse dataa ==>> $value");
      setState(() {
        warehouseData = value;
      });
      await systemProvider.fetchProducts(true, true, warehouseData[0]['id']);
    });
    setState(() {
      _products = data;
      _dataProducts = data;
      loadingProduct = false;
    });
    log("Product data ==>> $data");
    log("Warehouse dathggjhb ==>> $warehouseData");
  }

  Future<void> readCategories() async {
    final data = await widget.systemProvider.getCategories();
    print("---------current open register ----------");
    print(data);
    setState(() {
      categoryData = data;
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        // Handle the permission denial
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera permission is required to scan QR codes')),
        );
      }
    }
  }


  Future barcodeScan() async {
    _requestCameraPermission();
    //await Permission.camera.request();
    String? barcode = await FlutterScanner.scanBarcode(
        lineColor: '#ff6666',
        cancelButtonText: 'Cancel',
        isShowFlashIcon: true,
        scanMode: ScanMode.QR,
        isOrientationLandscape: false,
        isNeedLengthCondition: true,
        isNeedOnlyDigitCondition: true,
        minimunLengthMinusOne: 10,
        maximunLengthPlusOne: 50,
        iconSize: 50,
        fontSize: 20,);

    if (barcode == '-1') {
      print('nothing return.');
      setState(() {
        barcode = '';
      });
      Dialogs.alertDialog(
          context, "Warning", "Nothing was found!", "cancel", "save", []);
    } else {
      _barcodeController!.text = barcode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            capitalize(widget.category['name']),
            style: const TextStyle(color: whiteColor),
          ),
          actions: [
            // Navigate to the Search Screen
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CartMobile(
            //                   systemProvider: widget.systemProvider,
            //                 )));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         left: 0, right: 15, top: 5, bottom: 15),
            //     child: Stack(
            //       children: [
            //         const Align(
            //             alignment: Alignment.bottomCenter,
            //             child: Icon(Icons.shopping_cart_rounded,
            //                 color: Colors.white, size: 25)),
            //         Positioned(
            //           top: 0,
            //           left: 0,
            //           right: 0,
            //           child: Consumer<CartProvider>(
            //             builder: (context, value, child) => CartCounter(
            //               count: value.totalCart.toString(),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            IconButton(
                color: whiteColor,
                onPressed: () async {
                  await barcodeScan();
                  _searchProducts(_barcodeController!.text.trim());
                },
                icon: Icon(MdiIcons.barcodeScan))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 160.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SecondaryCustomDropDown(
                      color: Colors.grey.withOpacity(0.3),
                      hintText: selectedBranch == null ? "${warehouseData[0]['attributes']['name'] ?? "Select Branch"}" : selectedBranch?['attributes']['name'],
                      titleText: "", onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black.withOpacity(0.5),
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return CustomSelectorBottomSheet3(
                            height: 40.h,
                            onSelect: (value, index) async {
                              _barcodeController?.clear();
                              setState(() {
                                selectedBranch = value;
                                _productSearchResult = [];
                                _foundProducts = _productSearchResult;
                                loadingProduct = true;
                              });
                              await systemProvider.fetchProducts(true, true, selectedBranch?['id']);
                              var data = await widget.systemProvider.getProducts(1);
                              setState(() {
                                _products = data;
                                _dataProducts = data;
                                loadingProduct = false;
                              });
                              debugPrint("valueeee ===>> $selectedBranch");
                            },
                            items: warehouseData,);
                        });
                  }),
                ),

                SizedBox(height: 1.h,),

                // CustomDropdown<Map<String, dynamic>>(
                //   items: warehouseData,
                //   selectedItem: selectedBranch,
                //   getItemLabel: (item) => branches[0]['label'],
                //   onChanged: (value) async {
                //     setState(() {
                //       loadingProduct = true;
                //     });
                //     setState(() {
                //       selectedBranch = value!;
                //     });
                //     await systemProvider.fetchProducts(true, true, selectedBranch?['id']);
                //     var data = await widget.systemProvider.getProducts(1);
                //     setState(() {
                //       _products = data;
                //       _dataProducts = data;
                //       loadingProduct = false;
                //     });
                //   },
                //   hintText: selectedBranch == null ? "${warehouseData[0]['attributes']['name'] ?? "Select Branch"}" : selectedBranch?['attributes']['name'],
                //   dropdownColor: Colors.white,
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: PrimaryTextField(
                    controller: _barcodeController,
                    hintText: 'Search product by code or name',
                    title: '',
                    onChanged: (value) {
                      _searchProducts(value);
                    },
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _barcodeController?.clear();
                        setState(() {
                          _productSearchResult = _products;
                          _foundProducts = _productSearchResult;
                        });
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                // Material(
                //     elevation: 10,
                //     shadowColor: Colors.black38,
                //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                //     child: OutlineSearchBar(
                //       borderColor: primaryColor,
                //       textEditingController: _barcodeController,
                //       hintText: "Search product by code or name...",
                //       onClearButtonPressed: (value) {
                //         setState(() {
                //           _dataProducts = _products;
                //         });
                //       },
                //       onSearchButtonPressed: (value) {
                //         if (value.isEmpty) {
                //           setState(() {
                //             _dataProducts = _products;
                //           });
                //         } else {
                //           _filterProducts = _dataProducts
                //               .where((product) => (product['name']
                //                       .toLowerCase()
                //                       .contains(value.toLowerCase()) ||
                //                   product['code'] == value))
                //               .toList();
                //           setState(() {
                //             if (_filterProducts.isNotEmpty) {
                //               _dataProducts = _filterProducts;
                //             } else {
                //               _dataProducts = _products;
                //             }
                //           });
                //         }
                //       },
                //       onKeywordChanged: (value) {
                //         if (value.isEmpty) {
                //           setState(() {
                //             _dataProducts = _products;
                //           });
                //         } else {
                //           _filterProducts = _dataProducts
                //               .where((product) => (product['name']
                //                       .toLowerCase()
                //                       .contains(value.toLowerCase()) ||
                //                   product['code'] == value))
                //               .toList();
                //           setState(() {
                //             if (_filterProducts.isNotEmpty) {
                //               _dataProducts = _filterProducts;
                //             } else {
                //               _dataProducts = _products;
                //             }
                //           });
                //         }
                //       },
                //       searchButtonIconColor: primaryColor,
                //       borderRadius:
                //           const BorderRadius.all(Radius.circular(10.0)),
                //     )),
                const SizedBox(
                  height: 10,
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: selectedCategory == '' ? Colors.purple : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text("All", style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: selectedCategory == '' ? Colors.white : Colors.black
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 1.h,),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1,
                                  padding: EdgeInsets.zero,
                                  children:  categoryData.isEmpty ? [SizedBox()] : categoryData.map((cat) =>  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = cat['attributes']['name'];
                                      });
                                      print(selectedCategory);
                                      _filterByCategories();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      decoration: BoxDecoration(
                                          color: selectedCategory == cat['attributes']['name'] ? Colors.purple : Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Text(cat['attributes']['name'], style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: selectedCategory == cat['attributes']['name'] ? Colors.white : Colors.black
                                        ),),
                                      ),
                                    ),
                                  )).toSet().toList()),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 1.w,),

                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width* 0.6,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: _foundProducts!.isNotEmpty
                              ? searchView(_foundProducts)
                               : SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),

                //SizedBox(height: 2.h,),

                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: CartMobile(
                    systemProvider: widget.systemProvider,
                  ),
                ),

                // CartSummaryWidget(
                //   registerInfo: widget.registerInfo,
                //   isMobile: Responsive.isMobile(context),
                //   systemProvider: widget.systemProvider,
                //   user: widget.,
                // )


              ],
            ),
          ),
        ));
  }

  GridView searchView(data) {
    return GridView.builder(
      itemCount: data!.length,
      itemBuilder: (context, index) {
        var product = data![index]['attributes'];
        // Use a fallback image URL if no valid image URL is found
        final String imageUrl = (product['images'] is Map &&
                product['images']['imageUrls'] is List &&
                product['images']['imageUrls'].isNotEmpty &&
                product['images']['imageUrls'][0] is String)
            ? product['images']['imageUrls'][0]
            : 'https://via.placeholder.com/150';
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(imageUrl),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.5),
                      Colors.black54,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Column(
                  children: [

                    Expanded(
                      child: Text(
                        capitalize(product['name']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Money.format(
                            product['product_price'],
                          ),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Qty: ${product['stock']['quantity']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 1.h,
                    ),

                    GestureDetector(
                      onTap: () {
                        if (product['stock']['quantity'] == 0) {
                          Dialogs.alertDialog(context, "Warning",
                              "Product is out of stock!", "cancel", "save", []);
                        } else {
                          Provider.of<CartProvider>(context, listen: false).add(
                              product,
                              index,
                              generateRandomString(12),
                              product['product_price'],
                              1,
                              product['product_code']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product['name']} added to cart'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "Add to cart",
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                      ),
                    ),
                    //  ElevatedButton(
                    //   onPressed: () {
                    //     if (product['stock']['quantity'] == 0) {
                    //       Dialogs.alertDialog(context, "Warning",
                    //           "Product is out of stock!", "cancel", "save", []);
                    //     } else {
                    //       Provider.of<CartProvider>(context, listen: false).add(
                    //           product,
                    //           index,
                    //           generateRandomString(12),
                    //           product['product_price'],
                    //           1, product['product_code']);
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           content: Text('${product['name']} added to cart'),
                    //           duration: const Duration(seconds: 2),
                    //         ),
                    //       );
                    //     }
                    //   },
                    //   child: const Text(
                    //     'Add to Cart',
                    //     style: TextStyle(color: whiteColor, fontSize: 8),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  void _searchProducts(String? value) {
    print("Onchanged called");
    if (_barcodeController!.text.isEmpty) {
      // If the search field is empty or only contains white-space
      setState(() {
        _productSearchResult = _products;
        _foundProducts = _productSearchResult;
      });
    } else {
      setState(() {
        if (_barcodeController!.text.contains(RegExp('[a-zA-Z]'))) {
          _productSearchResult = _products.where((beneficiary) {
            return beneficiary['attributes']['name']
                .toLowerCase()
                .contains(_barcodeController!.text.toLowerCase());
          }).toList();
          _foundProducts = _productSearchResult;
        } else {
          _productSearchResult = _products.where((beneficiary) {
            return beneficiary['attributes']['product_code']
                .toLowerCase()
                .contains(_barcodeController!.text.toLowerCase());
          }).toList();
          _foundProducts = _productSearchResult;
        }
      });
      //debugPrint(_foundProducts.toString());
    }
    debugPrint(_foundProducts.toString());
  }

  void _filterByCategories() {
    print("Filter by category");
    if (selectedCategory == '') {
      // If the search field is empty or only contains white-space
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
      //debugPrint(_foundProducts.toString());
    }
    debugPrint(_foundProducts.toString());
  }
}

class TekFlutterScannerConfig {
  const TekFlutterScannerConfig({
    required this.showAppBar,
    required this.appBarTitle,
    required this.appBarColor,
    required this.description
  });

  final bool showAppBar;
  final String appBarTitle;
  final String appBarColor;
  final String description;
}

class Products {
  final String img, title, desc, code;
  int quantity;
  final double amount;

  Products(
      {required this.img,
      required this.title,
      required this.desc,
      required this.amount,
      required this.quantity,
      required this.code});
}
