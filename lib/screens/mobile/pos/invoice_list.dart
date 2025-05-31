import 'dart:convert';

import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../common/provider/user_provider.dart';
import '../../../data/models/userdetails.dart';
import '../../desktop/pos/print_invoices.dart';
import '../../desktop/pos/printusb.dart';

class InvoiceListMobile extends StatefulWidget {
  final Size mediaQuery;
  final SystemProvider systemProvider;
  final Map registerInfo;
  final VoidCallback closeInvoice;

  const InvoiceListMobile({
    super.key,
    required this.mediaQuery,
    required this.systemProvider,
    required this.registerInfo,
    required this.closeInvoice,
  });

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceListMobile> {
  List<dynamic> _invoices = [];
  int? selectedInvoiceIndex;

  @override
  void initState() {
    super.initState();
    _loadInvoices();
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
      return await widget.systemProvider.getInvoices(widget.registerInfo['id']);
    } catch (e) {
      print('Error fetching invoices: $e');
      return [];
    }
  }

  // Delete a specific invoice by ID and remove it from the list
  Future<void> deleteInvoice(int id) async {
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

  // Clear all invoices for a specific register and update the list
  Future<void> clearInvoices() async {
    try {
      await widget.systemProvider.clearInvoices();
      if (mounted) {
        setState(() {
          _invoices.clear();
        });
      }
      print('All invoices cleared for register ${widget.registerInfo['id']}');
    } catch (e) {
      print('Error clearing invoices: $e');
    }
  }

  @override
  void dispose() {
    // Perform any necessary cleanup here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.mediaQuery.width, // Adjust width based on screen size
      constraints: BoxConstraints(
        maxHeight: widget.mediaQuery.height * 0.96,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Invoice List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: widget.closeInvoice,
              child: const Text(
                "Close",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.normal),
              ),
            )
          ]),
          const SizedBox(height: 5),
          Expanded(
            child: _invoices.isEmpty
                ? const Center(child: Text("No items available"))
                : ListView.builder(
                    itemCount: _invoices.length,
                    itemBuilder: (context, index) {
                      var item = _invoices[index];
                      return Dismissible(
                        key: ValueKey<int>(item['id']),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: primaryColor,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          deleteInvoice(item['id']);
                        },
                        child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 1),
                            title: Text(
                              item['reference'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Customer: ${item['customerName']}",
                                  style: TextStyle(color: grayColor),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Amount: ${Money.format(item['amount'])}",
                                      style: TextStyle(color: grayColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: Icon(MdiIcons.redoVariant),
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .redoInvoice(item['invoice'], item['id'], index);
                                  //deleteInvoice(item['id']);
                                  widget.closeInvoice();
                                },
                              ),
                              IconButton(
                                icon: Icon(MdiIcons.printer),
                                onPressed: () {
                                  setState(() {
                                    selectedInvoiceIndex = index;
                                  });
                                  printInvoice();
                                },
                              ),
                            ])),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          _invoices.isEmpty
              ? const SizedBox()
              : CustomButton(
                  label: "Clear all",
                  icon: MdiIcons.deleteEmptyOutline,
                  color: Colors.redAccent,
                  onTap: clearInvoices,
                ),
        ],
      ),
    );
  }

  printInvoice() async {
    //var othersData = json.decode(widget.transactionData['others']);
    UserDetails user = Provider.of<UserProvider>(context, listen: false).user;

    // Ensure the items data is in the correct format
    List<dynamic> itemsData;
    // try {
    //   itemsData = json.decode(_invoices);
    // } catch (e) {
    //   print("Error decoding items: $e");
    //   return; // Exit if decoding fails
    // }

    var invoiceData = jsonDecode(_invoices[selectedInvoiceIndex!]['invoice']);
    var invoice = _invoices[selectedInvoiceIndex!];
    print(invoice);
    String invoiceId = invoice['reference'];

    List<Item> items = [];

    print("invoicess ==>> $invoiceData");

    // Parse the items
    for (var itemData in invoiceData) {
      if (itemData is Map<String, dynamic>) {
        var product = itemData['product'];
        print("productssss ==>> $product");

        // Check if product is a map
        String itemName = product['name'] as String;
        int quantity = itemData['quantity'] as int;

        double totalAmount;
        if (itemData['totalAmount'] is String) {
          totalAmount = double.tryParse(itemData['totalAmount']) ??
              0.0; // Handle String to double
        } else if (itemData['totalAmount'] is int) {
          totalAmount = (itemData['totalAmount'] as int)
              .toDouble(); // Convert int to double
        } else if (itemData['totalAmount'] is double) {
          totalAmount = itemData['totalAmount']; // Already a double
        } else {
          totalAmount = 0.0; // Default value in case of unexpected type
        }

        Item item = Item(itemName, quantity, totalAmount);
        items.add(item);
      } else {
        print('Expected itemData to be a Map, but got: $itemData');
      }
    }

    double totalAmount = items.map((item) => item.price).reduce((a, b) => a + b);

    print("------------ items data -------------");

    print(items);

    try {
      await printInvoiceDocument(
        invoice['amount'],
        items,
        user.company!.email,
        user.company!.phone,
        user.firstName,
        0.00,
        0.00,
        DateTime.now(),
        invoice['reference'],
        invoice['lastUpdated'],
        invoiceData[selectedInvoiceIndex]['product']['warehouse'][0]['name'],
        user.company!.name,
        user.company!.address,
        invoice['customerName'] ?? "",
        invoice['customerPhone'] ?? "",
        invoice['tableId'] ?? "",
      );

      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }
}
