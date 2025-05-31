import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/responsive.dart';

import '../../../widgets/dialogs.dart';
import 'cart_summary.dart';
import 'invoice_list.dart';

class CartMobile extends StatefulWidget {
  final SystemProvider systemProvider;
  const CartMobile({super.key, required this.systemProvider});

  @override
  State<CartMobile> createState() => _CartMobileState();
}

class _CartMobileState extends State<CartMobile> {
  final TextEditingController _textFieldController =
      TextEditingController(text: 'Walk-in-customer');

  bool _isInvoiceOpen = false;
  Map _registerInfo = {};

  @override
  void initState() {
    super.initState();
    readRegisterInfo();
  }

  Future<void> readRegisterInfo() async {
    final data = await widget.systemProvider.getCurrentRegister();
    print("---------current open register ----------");
    print(data);
    setState(() {
      _registerInfo = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    UserDetails user = Provider.of<UserProvider>(context).user;

    return Consumer<CartProvider>(
      builder: (context, cart, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cart.items.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: GestureDetector(
                                            onTap: () {
                        cart.removeAll();
                        //Navigator.pop(context);
                                            },
                                            child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Text("Clear Cart", style: TextStyle(
                            color: Colors.white
                        ),),
                                            ),),
                      )
                      : SizedBox(),

                  SizedBox(width: 3.w,),

                  _isInvoiceOpen
                      ? const SizedBox()
                      :  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_registerInfo.isNotEmpty) {
                          _isInvoiceOpen = true;
                        }
                      });
                    },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(100)
                                              ),
                                              child: Text("Show Invoice", style: TextStyle(
                                                color: Colors.white
                                              ),),
                                            ),)
                      // ),IconButton(
                      // color: const Color.fromARGB(255, 244, 183, 183),
                      // onPressed: () {
                      //   setState(() {
                      //     if (_registerInfo.isNotEmpty) {
                      //       _isInvoiceOpen = true;
                      //     }
                      //   });
                      // },
                      // icon: Icon(MdiIcons.menu)),
                ],
              ),

              SizedBox(height: 1.h,),

              _isInvoiceOpen
                  ? Expanded(
                    child: InvoiceListMobile(
                    mediaQuery: MediaQuery.of(context).size,
                    systemProvider: widget.systemProvider,
                    registerInfo: _registerInfo,
                    closeInvoice: () {
                      print("------------- close invoice -----------");
                      setState(() {
                        if (_registerInfo.isNotEmpty) {
                          _isInvoiceOpen = false;
                        }
                      });
                    }),
                  )
                  : Expanded(
                    child: Container(
                                   // height: screenSize.height,
                                    //width: double.infinity,
                                    child: cart.items.isEmpty
                      ? Center(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/emptycart.png", height: 15.h,),
                          Text("Cart is currently empty\nAdd items to cart", textAlign: TextAlign.center,),
                        ],
                      ),)
                      : ListView.builder(
                                          shrinkWrap: false,
                                          itemCount: cart.items.length,
                                          itemBuilder: (context, index) {
                      var product = cart.items[index].product!;
                      var cartItem = cart.items[index];
                      final String imageUrl = (product['images'] is Map &&
                          product['images']['imageUrls'] is List &&
                          product['images']['imageUrls'].isNotEmpty &&
                          product['images']['imageUrls'][0] is String)
                          ? product['images']['imageUrls'][0]
                          : 'https://via.placeholder.com/150';
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: primaryColor,
                        ),
                        onDismissed: (direction) {
                          cart.del(index);
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.only(right: 0, left: 10),
                          onTap: () {
                            // showBS(context, index, product);
                          },
                          title: Text(
                            product['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CachedNetworkImage(
                            height: screenSize.height * 0.13,
                            width: screenSize.width * 0.1,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            imageUrl: imageUrl,
                          ),
                          subtitle:
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Money.format(cartItem.totalAmount!)),
                              IconButton(
                                iconSize: 16,
                                icon: Icon(MdiIcons.delete),
                                onPressed: () {
                                  cart.del(index);
                                },
                              ),
                              IconButton(
                                iconSize: 16,
                                icon: Icon(MdiIcons.pencil),
                                onPressed: () {
                                  _editPrice(
                                    context,
                                    cartItem.trackID!,
                                    cartItem.totalAmount!,
                                  );
                                },
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                      listen: false)
                                      .decrementQuantity(index);
                                },
                              ),
                              SizedBox(width: 3.w,),
                              GestureDetector(
                                onTap: () {
                                  _editQuantity(
                                    context,
                                    index,
                                    cartItem.quantity,
                                  );
                                },
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 18.sp),
                                ),
                              ),
                              SizedBox(width: 3.w,),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                      listen: false)
                                      .incrementQuantity(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                                          },
                                    ),
                                  ),
                  ),

              CartSummaryWidget(
                registerInfo: _registerInfo,
                isMobile: Responsive.isMobile(context),
                systemProvider: widget.systemProvider,
                user: user,
              )
            ],
          ),
    );
  }

  // Padding(
  //               padding: const EdgeInsets.all(10),
  //               child: SizedBox(
  //                 width: double.infinity,
  //                 child: ButtonGradWidget(
  //                   onPress: () {
  //                     // value.summary(
  //                     //     context, widget.systemProvider, value.items);
  //                     if (cart.items.length == 0) {
  //                       Dialogs.alertDialog(context, "Warning",
  //                           "Cart is Empty!", "cancel", "save", []);
  //                       return;
  //                     }
  //                     _displayTextInputDialog(
  //                         context, widget.systemProvider, cart);
  //                   },
  //                   title: 'Checkout',
  //                   isLoading: false,
  //                   buttonColor: primaryColor,
  //                   titleColor: whiteColor,
  //                   borderColor: primaryColor,
  //                   paddingHorizontal: 15.0,
  //                   paddingVertical: 15.0,
  //                 ),
  //               ),
  //             )

  showBS(context, index, product) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "${product['name']}",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      imageUrl:
                          "https://gagahotels.ebeanomarket.com/public/images/products/${product['image']}",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                buildInfoRow(
                    "Product Type",
                    product['product_type'] == 'is_single'
                        ? "Single"
                        : "Not Single"),
                buildInfoRow("Product Code", "${product['code']}"),
                buildInfoRow("Product Cost", Money.format(product['cost'])),
                buildInfoRow(
                    "Product Price", Money.format(product['product_price'])),
                buildInfoRow("Quantity Available", "${product['qte_sale']}"),
                buildInfoRow("Stock Alert", "${product['stock_alert']}"),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context,
      SystemProvider systemProvider, CartProvider cart) async {
    UserDetails user = Provider.of<UserProvider>(context).user;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Customer Name'),
            content: TextField(
              controller: _textFieldController,
              decoration:
                  const InputDecoration(hintText: "E.g Walk-in-customer"),
            ),
            actions: <Widget>[
              GestureDetector(
                child: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 25,
              ),
              GestureDetector(
                child: const Text(
                  'Proceed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  cart.summary(context, widget.systemProvider,
                      _textFieldController.text, cart.items,);
                },
              ),
            ],
          );
        });
  }

  void _editPrice(BuildContext context, String trackID, int currentPrice) {
    final TextEditingController priceController = TextEditingController(
      text: currentPrice.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Price"),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "New Price"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newPrice = int.tryParse(priceController.text);
                if (newPrice != null) {
                  Provider.of<CartProvider>(context, listen: false)
                      .updateProductPrice(trackID, newPrice);
                  Navigator.of(context).pop();
                } else {
                  // Show error if the price is not a valid number
                  Dialogs.alertDialog(
                    context,
                    "Invalid Price",
                    "Please enter a valid price.",
                    "OK",
                    "",
                    [],
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _editQuantity(BuildContext context, int index, int currentQuantity) {
    final TextEditingController quantityController = TextEditingController(
      text: currentQuantity.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Quantity"),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Quantity"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newQuantity = int.tryParse(quantityController.text);
                if (newQuantity != null) {
                  Provider.of<CartProvider>(context, listen: false)
                      .updateQuantity(index, newQuantity);
                  Navigator.of(context).pop();
                } else {
                  // Show error if the price is not a valid number
                  Dialogs.alertDialog(
                    context,
                    "Invalid Quantity",
                    "Please enter a valid quantity.",
                    "OK",
                    "",
                    [],
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
