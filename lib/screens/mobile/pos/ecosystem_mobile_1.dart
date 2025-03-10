import 'package:spotstock_inventory/common/common.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/outline_search_bar/outline_search_bar.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'cart_mobile.dart';
//import 'package:qrscan/qrscan.dart' as scanner;

class EcosystemMobileScreen extends StatefulWidget {
  final SystemProvider systemProvider;
  final Map<String, dynamic> category;
  final int? id;

  const EcosystemMobileScreen(
      {super.key,
      required this.systemProvider,
      required this.category,
      this.id = 0});

  @override
  State<EcosystemMobileScreen> createState() => _EcosystemMobileScreenState();
}

List _products = [];
List _filterProducts = [];
List _dataProducts = [];
bool _searching = false;

class _EcosystemMobileScreenState extends State<EcosystemMobileScreen> {
  TextEditingController? _barcodeController;

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController();
    readProducts();
  }

  Future<List<dynamic>> getProducts() async {
    return await widget.systemProvider.getProducts(widget.category['id']);
  }

  Future<void> readProducts() async {
    final data = await widget.systemProvider.getProducts(widget.category['id']);
    setState(() {
      _products = data;
      _dataProducts = data;
    });
  }

  Future barcodeScan() async {
    await Permission.camera.request();
    //String? barcode = await scanner.scan();
    String? barcode = ""; //await scanner.scan();
    if (barcode == null || barcode == "-1") {
      setState(() {
        barcode = null;
      });
      print('nothing return.');
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartMobile(
                              systemProvider: widget.systemProvider,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 15, top: 8, bottom: 12),
                child: Stack(
                  children: [
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(Icons.shopping_cart_rounded,
                            color: Colors.white, size: 25)),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Consumer<CartProvider>(
                        builder: (context, value, child) => CartCounter(
                          count: value.totalCart.toString(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
                color: whiteColor,
                onPressed: () async {
                  await barcodeScan();
                },
                icon: Icon(MdiIcons.barcodeScan))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                    elevation: 10,
                    shadowColor: Colors.black38,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: OutlineSearchBar(
                      borderColor: primaryColor,
                      textEditingController: _barcodeController,
                      hintText: "Search product by code or name...",
                      onClearButtonPressed: (value) {
                        setState(() {
                          _dataProducts = _products;
                        });
                      },
                      onSearchButtonPressed: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _dataProducts = _products;
                          });
                        } else {
                          _filterProducts = _dataProducts
                              .where((product) => (product['name']
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  product['code'] == value))
                              .toList();
                          setState(() {
                            if (_filterProducts.isNotEmpty) {
                              _dataProducts = _filterProducts;
                            } else {
                              _dataProducts = _products;
                            }
                          });
                        }
                      },
                      onKeywordChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _dataProducts = _products;
                          });
                        } else {
                          _filterProducts = _dataProducts
                              .where((product) => (product['name']
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  product['code'] == value))
                              .toList();
                          setState(() {
                            if (_filterProducts.isNotEmpty) {
                              _dataProducts = _filterProducts;
                            } else {
                              _dataProducts = _products;
                            }
                          });
                        }
                      },
                      searchButtonIconColor: primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: _dataProducts.isNotEmpty
                        ? searchView(_dataProducts)
                        : FutureBuilder(
                            future: getProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                // Future hasn't finished yet, return a placeholder
                                return const Text('Loading');
                              }
                              print("-----------list products------------");
                              print('Loading Complete: ${snapshot.data}');
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      2, // number of items in each row
                                  mainAxisSpacing: 8.0, // spacing between rows
                                  crossAxisSpacing:
                                      10.0, // spacing between columns
                                ),
                                padding: const EdgeInsets.all(
                                    8.0), // padding around the grid
                                itemCount: snapshot
                                    .data!.length, // total number of items
                                itemBuilder: (context, index) {
                                  var product = snapshot.data![index];

                                  return GestureDetector(
                                      onTap: () {
                                        showBS(
                                            context, index, product, setState);
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return EcosystemMobileScreen(
                                        //     systemProvider: widget.systemProvider,
                                        //     category: category,
                                        //   );
                                        // }));
                                      },
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://gagahotels.ebeanomarket.com/public/images/products/${product['image']}"),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                gradient: LinearGradient(
                                                    begin: FractionalOffset
                                                        .topCenter,
                                                    end: FractionalOffset
                                                        .bottomCenter,
                                                    colors: [
                                                      Colors.grey
                                                          .withOpacity(0.0),
                                                      Colors.black54,
                                                    ],
                                                    stops: const [
                                                      0.0,
                                                      1.0
                                                    ])),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                product['qte_sale'] == 0
                                                    ? Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: SizedBox(
                                                          height: 20,
                                                          width: 90,
                                                          child: Material(
                                                              color:
                                                                  primaryColor,
                                                              elevation: 13,
                                                              shadowColor:
                                                                  Colors
                                                                      .black54,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Text(
                                                                "Out of stock",
                                                                style: TextStyle(
                                                                    color:
                                                                        whiteColor),
                                                              ))),
                                                        ))
                                                    : const SizedBox(
                                                        height: 20,
                                                      ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      16,
                                                ),
                                                Text(
                                                  capitalize(product['name']),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  Money.format(
                                                      product['Net_price']),
                                                  overflow: TextOverflow.fade,
                                                  style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                              );
                            }))
              ],
            )));
  }

  GridView searchView(data) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 10.0, // spacing between columns
      ),
      padding: const EdgeInsets.all(8.0), // padding around the grid
      itemCount: data!.length, // total number of items
      itemBuilder: (context, index) {
        var product = data![index];

        return GestureDetector(
            onTap: () {
              showBS(context, index, product, setState);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) {
              //   return EcosystemMobileScreen(
              //     systemProvider: widget.systemProvider,
              //     category: category,
              //   );
              // }));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://gagahotels.ebeanomarket.com/public/images/products/${product['image']}"),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.black54,
                          ],
                          stops: const [
                            0.0,
                            1.0
                          ])),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      product['qte_sale'] == 0
                          ? Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                height: 20,
                                width: 90,
                                child: Material(
                                    color: primaryColor,
                                    elevation: 13,
                                    shadowColor: Colors.black54,
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: const Center(
                                        child: Text(
                                      "Out of stock",
                                      style: TextStyle(color: whiteColor),
                                    ))),
                              ))
                          : const SizedBox(
                              height: 20,
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                      Text(
                        capitalize(product['name']),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Money.format(product['Net_price']),
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  showBS(contxt, index, product, StateSetter setTimezoneState) {
    showModalBottomSheet(
      context: contxt,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 1.0),
                child: Column(children: [
                  Text("${product['name']}",
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Product Type:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      product['product_type'] == 'is_single'
                          ? const Text(
                              "Single",
                              style: TextStyle(fontSize: 16),
                            )
                          : const Text(
                              "Not Single",
                              style: TextStyle(fontSize: 16),
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Product Code:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${product['code']}",
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Product Cost:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Money.format(product['cost']),
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Product Price:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Money.format(product['Net_price']),
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Quantity Available:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${product['qte_sale']}",
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Stock Alert:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${product['stock_alert']}",
                        style: const TextStyle(fontSize: 19),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<CartProvider>(
                      builder: (context, value, child) => SizedBox(
                            width: double.infinity,
                            child: ButtonGradWidget(
                              onPress: () {
                                if (product['qte_sale'] == 0) {
                                  Dialogs.alertDialog(
                                      context,
                                      "Warning",
                                      "Product is out of stock!",
                                      "cancel",
                                      "save", []);
                                } else {
                                  value.add(
                                      product,
                                      index,
                                      generateRandomString(12),
                                      product['Net_price'],
                                      1, product['product_code']);
                                  const snackdemo = SnackBar(
                                    content: Text('Added to Cart!'),
                                    // backgroundColor: Colors.green,
                                    elevation: 10,
                                    // behavior: SnackBarBehavior.floating,
                                    behavior: SnackBarBehavior.floating,
                                    // margin: EdgeInsets.only(bottom: 100.0),
                                    margin: EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(contxt)
                                      .showSnackBar(snackdemo);
                                }
                                Navigator.pop(context);
                              },
                              title: 'Add to Cart',
                              isLoading: false,
                              buttonColor: primaryColor,
                              titleColor: whiteColor,
                              borderColor: primaryColor,
                              paddingHorizontal: 15.0,
                              paddingVertical: 15.0,
                            ),
                          )),
                ]),
              ));
        });
      },
    );
  }
}


class Products {
  final String img, title, desc, amount, quantity, code;
  Products(
      {required this.img,
      required this.title,
      required this.desc,
      required this.amount,
      required this.quantity,
      required this.code});
}
