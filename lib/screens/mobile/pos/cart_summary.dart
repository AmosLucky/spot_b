import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/payform.dart';
import 'package:spotstock_inventory/screens/mobile/pos/print_mobile.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';

import '../../desktop/pos/widgets/payform_invoice.dart';

class CartSummaryWidget extends StatefulWidget {
  final Map<dynamic, dynamic> registerInfo;
  final bool isMobile;
  final SystemProvider systemProvider;
  final UserDetails user;

  const CartSummaryWidget(
      {super.key,
      required this.registerInfo,
      this.isMobile = true,
      required this.systemProvider,
      required this.user});

  @override
  State<CartSummaryWidget> createState() => _CartSummaryWidgetState();
}

class _CartSummaryWidgetState extends State<CartSummaryWidget> {
  List<dynamic> _invoices = [];

  List<dynamic> invoices = [];

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
      invoices = await widget.systemProvider.getInvoices(widget.registerInfo['id']);
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
          isInvoice: false,
          data: cartProvider.selectedIndex != null ? {
            "customerName": invoices[cartProvider
                .selectedIndex!]['customerName'],
            "customerPhoneNumber": invoices[cartProvider
                .selectedIndex!]['customerPhone'],
            "table": invoices[cartProvider
                .selectedIndex!]['tableId']
          } : {},
          app: 'pos',
          systemProvider: widget.systemProvider,
          subtotal: subtotal,
          onSubmit: (paymentData) async {
            paymentData['registerId'] = widget.registerInfo['id'];

            try {
              final value =
                  await Provider.of<CartProvider>(context, listen: false)
                      .checkout(context, subtotal, paymentData);

              if (value['status'] == true && value['txnID'] != null) {
                var response = await getReceiptTxn(value['txnID']);
                if (response.isNotEmpty && context.mounted) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PrintMobileScreenDialog(
                            user: widget.user,
                            transactionData: response,
                          )));
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 213, 212, 212),
            blurRadius: 8.0,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: widget.isMobile
            ? const EdgeInsets.all(20)
            : const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Consumer<CartProvider>(
          builder: (context, cart, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Items QTY: ${cart.totalCart}"),
                  Text(
                    "Total: ${Money.format(cart.subTotal)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.registerInfo['id'] != null
                      ? CustomButton(
                          label: "Invoice",
                          width: widget.isMobile ? 150.0 : 250,
                          icon: MdiIcons.handBackLeft,
                          color: secondaryColor,
                          onTap: () async {
                            await getInvoices();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Consumer<CartProvider>(
                                      builder: (context, cartProvider, child) => PayFormInvoice(data: cartProvider.selectedIndex != null ? {
                                    "customerName": invoices[cartProvider
                                        .selectedIndex!]['customerName'],
                                    "customerPhoneNumber": invoices[cartProvider
                                        .selectedIndex!]['customerPhone'],
                                    "table": invoices[cartProvider
                                        .selectedIndex!]['tableId']
                                  } : {}, onSubmit: (value)  async {
                                    var response = await cart.holdInvoice(
                                      context,
                                      widget.registerInfo['id'],
                                      cart.subTotal, value['table'], value['customerName'], value['customerPhoneNumber'],
                                    );
                                    for(var i in invoices) {
                                      if(i['id'] == cartProvider.selectedInvoiceId) {
                                        print('ID ==>> ${i['id']}');
                                        deleteInvoice(i['id']);
                                      }
                                      Provider.of<CartProvider>(context, listen: false)
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
                                      systemProvider: widget.systemProvider));
                                });
                          },
                        )
                      : const SizedBox(),
                  CustomButton(
                    label: "Clear",
                    icon: MdiIcons.close,
                    width: widget.isMobile ? 150.0 : 250,
                    color: Colors.red,
                    onTap: () => cart.removeAll(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}
