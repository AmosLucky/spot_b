import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/payform_invoice.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'payform.dart';

class OrderSummary extends StatefulWidget {
  final List<dynamic> products;
  final Size mediaQuery;
  final Map registerInfo;
  final SystemProvider systemProvider;
  final UserDetails user;

  const OrderSummary({
    super.key,
    required this.products,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
  });

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  List<dynamic> _invoices = [];
  List<dynamic> invoices = [];

  // Retrieve the receipt transaction details using the provided transaction ID.
  Future<Map<String, dynamic>> getReceiptTxn(String txnID) async {
    return await widget.systemProvider.getReceiptTxn(txnID);
  }

  // Load invoices when the widget initializes
  void _loadInvoices() async {
    var invoices = await getInvoices();
    if (mounted) {
      setState(() {
        _invoices = invoices;
      });
      print("Invoices ==>> $_invoices");
    }
  }

  // Fetch invoices for the specified register
  Future<List<dynamic>> getInvoices() async {
    try {
      invoices =
          await widget.systemProvider.getInvoices(widget.registerInfo['id']);
      return await widget.systemProvider.getInvoices(widget.registerInfo['id']);
    } catch (e) {
      print('Error fetching invoices: $e');
      return [];
    }
  }

  // Delete a specific invoice by ID and remove it from the list
  Future<void> deleteInvoice(int id) async {
    _loadInvoices();
    try {
      await widget.systemProvider.deleteInvoice(id);
      if (mounted) {
        setState(() {
          _invoices.removeWhere((invoice) => invoice['id'] == id);
        });
      }
      print('Invoice $id deleted successfully.');
    } catch (e) {
      print('Error deleting invoice $id: $e');
    }
  }

  // Method to show the payment dialog
  Future<void> _showPaymentDialog(BuildContext context, double subtotal) async {
    await getInvoices();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<CartProvider>(
            builder: (context, cartProvider, child) => PaymentForm(
                  isInvoice: cartProvider.selectedIndex != null ? true : false,
                  data: cartProvider.selectedIndex != null
                      ? {
                          "customerName": invoices[cartProvider.selectedIndex!]
                              ['customerName'],
                          "customerPhoneNumber":
                              invoices[cartProvider.selectedIndex!]
                                  ['customerPhone'],
                          "table": invoices[cartProvider.selectedIndex!]
                              ['tableId']
                        }
                      : {},
                  app: 'pos',
                  systemProvider: widget.systemProvider,
                  subtotal: subtotal,
                  onSubmit: (paymentData) async {
                    paymentData['registerId'] = widget.registerInfo['id'];

                    try {
                      final value = await Provider.of<CartProvider>(context,
                              listen: false)
                          .checkout(context, subtotal, paymentData);

                      if (value['status'] == true && value['txnID'] != null) {
                        var response = await getReceiptTxn(value['txnID']);
                        if (response.isNotEmpty && context.mounted) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => PrintScreenDialog(
                                    user: widget.user,
                                    transactionData: response,
                                  )));
                          // for(var i in _invoices) {
                          //   if(i['id'] = cart)
                          // }
                          await deleteInvoice(cartProvider.selectedInvoiceId);
                          Provider.of<CartProvider>(context, listen: false)
                              .deleteIndex();
                        }
                      } else {
                        // Show error dialog or message
                        Dialogs.alertDialog(
                          context,
                          "Payment Failed",
                          "Something went wrong during the transaction. Please try again.",
                          "OK",
                          "",
                          [],
                        );
                      }
                    } catch (e) {
                      // Handle exceptions and show an error message.
                      Dialogs.alertDialog(
                        context,
                        "Error",
                        "An unexpected error occurred: ${e.toString()}",
                        "OK",
                        "",
                        [],
                      );
                    }
                  },
                ));
      },
    );
  }

  // Method to show dialog to edit the price
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.mediaQuery.width * 0.3, // Adjust width based on screen size
      constraints: BoxConstraints(
        maxHeight: widget.mediaQuery.height * 0.96,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Order Summary",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Consumer<CartProvider>(
            builder: (context, cart, child) => cart.items.isEmpty
                ? const Center(child: Text("No items available"))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      var product = cart.items[index].product!;
                      var cartItem = cart.items[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        background: Container(color: primaryColor),
                        onDismissed: (direction) {
                          cart.del(index);
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1),
                          title: Text(
                            product['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Money.format(cartItem.totalAmount!),
                                style: TextStyle(color: grayColor),
                              ),
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
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      cart.decrementQuantity(index);
                                    },
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _editQuantity(
                                    context,
                                    index,
                                    cartItem.quantity!,
                                  );
                                },
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 12.sp),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cart.incrementQuantity(index);
                                    },
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        Consumer<CartProvider>(
          builder: (context, cart, child) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Items QTY: ${cart.totalCart}"),
              Text(
                "Total: ${Money.format(cart.subTotal)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Consumer<CartProvider>(
          builder: (context, cart, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.registerInfo['id'] != null
                      ? CustomButton(
                          label: "Invoice",
                          icon: MdiIcons.handBackLeft,
                          color: secondaryColor,
                          onTap: () async {
                            if (cart.totalCart > 0) {
                              await getInvoices();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Consumer<CartProvider>(
                                        builder: (context, cartProvider,
                                                child) =>
                                            PayFormInvoice(
                                                data: cartProvider
                                                            .selectedIndex !=
                                                        null
                                                    ? {
                                                        "customerName": invoices[
                                                                cartProvider
                                                                    .selectedIndex!]
                                                            ['customerName'],
                                                        "customerPhoneNumber":
                                                            invoices[cartProvider
                                                                    .selectedIndex!]
                                                                [
                                                                'customerPhone'],
                                                        "table": invoices[
                                                                cartProvider
                                                                    .selectedIndex!]
                                                            ['tableId']
                                                      }
                                                    : {},
                                                onSubmit: (value) async {
                                                  var response =
                                                      await cart.holdInvoice(
                                                    context,
                                                    widget.registerInfo['id'],
                                                    cart.subTotal,
                                                    value['table'],
                                                    value['customerName'],
                                                    value[
                                                        'customerPhoneNumber'],
                                                  );
                                                  for (var i in invoices) {
                                                    if (i['id'] ==
                                                        cartProvider
                                                            .selectedInvoiceId) {
                                                      print(
                                                          'ID ==>> ${i['id']}');
                                                      deleteInvoice(i['id']);
                                                    }
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .deleteIndex();
                                                  }

                                                  Dialogs.alertDialog(
                                                    context,
                                                    "Success!",
                                                    "Invoice moved to hold. Ref: ${response['reference']}",
                                                    "OK",
                                                    "",
                                                    [],
                                                  );
                                                },
                                                systemProvider:
                                                    widget.systemProvider));
                                  });
                            }
                          })
                      : const SizedBox(),
                  CustomButton(
                    label: "Clear",
                    icon: MdiIcons.close,
                    color: Colors.red,
                    onTap: () => cart.removeAll(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomButton(
                label: "Pay",
                icon: MdiIcons.cash,
                color: Colors.green,
                onTap: () {
                  if (cart.totalCart > 0) {
                    _showPaymentDialog(context, cart.subTotal);
                  }
                },
              ),
            ],
          ),
        ),
      ]),
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
