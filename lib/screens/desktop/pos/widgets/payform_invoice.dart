import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

class PayFormInvoice extends StatefulWidget {
  final SystemProvider systemProvider;
  final Map data;
  final Function(Map<String, dynamic>) onSubmit;

  const PayFormInvoice(
      {super.key,
        required this.data,
        required this.onSubmit,
        required this.systemProvider});

  @override
  State<PayFormInvoice> createState() => _PayFormInvoiceState();
}

class _PayFormInvoiceState extends State<PayFormInvoice> {
  List<String> customers = [];
  List<String> tables = [];
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController receivedAmountController =
  TextEditingController();
  final TextEditingController partialAmountController = TextEditingController();
  final tableNameController = TextEditingController();
  final customerPhoneController = TextEditingController();

  String paymentType = 'Cash';
  String paymentStatus = 'Paid';
  double change = 0.0;
  String? selectedCustomer;
  String? selectedTable;
  bool isCustomName = false;

  @override
  void initState() {
    super.initState();
    print("details ==>> ${widget.data['table']}");
    isCustomName = widget.data['customerName'] != null ? true :  false;
    customerNameController.text = widget.data['customerName'] ?? "Walk-in Customer";
    tableNameController.text = widget.data['table'] ?? "Select a table";
    customerPhoneController.text = widget.data['customerPhoneNumber'] ?? "Enter phone number";
    _loadCustomers();
    _loadTables();
  }

  void _loadCustomers() async {
    var _customers = await getCustomers();
    if (mounted) {
      setState(() {
        customers = _customers;
      });
    }
  }

  void _loadTables() async {
    var _tables = await getTables();
    if (mounted) {
      setState(() {
        tables = _tables;
      });
    }
  }

  Future<List<String>> getCustomers() async {
    try {
      var response = await widget.systemProvider.getCustomers();
      return response
          .map((customer) => customer['attributes']['name'] as String)
          .toList();
    } catch (e) {
      print('Error fetching invoices: $e');
      return [];
    }
  }

  Future<List<String>> getTables() async {
    try {
      var response = await widget.systemProvider.getTables();
      return response
          .map((customer) => customer['attributes']['name'] as String)
          .toList();
    } catch (e) {
      print('Error fetching invoices: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Invoice"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Customer: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                  activeColor: Colors.grey, // Color of the switch when it's on
                  inactiveThumbColor:
                  Colors.grey, // Color of the switch thumb when it's off
                  inactiveTrackColor: Colors.grey[300],
                  value: isCustomName,
                  onChanged: (value) {
                    setState(() {
                      isCustomName = value;
                      if (!isCustomName) {
                        customerNameController.text =
                            selectedCustomer ?? "Walk-in Customer";
                      } else {
                        customerNameController.clear();
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            isCustomName
                ? TextField(
              controller: customerNameController,
              decoration:
              const InputDecoration(labelText: "Enter Customer Name"),
            )
                : DropdownButton<String>(
              isExpanded: true,
              value: selectedCustomer,
              hint: Text(customerNameController.text),
              items: customers
                  .map<DropdownMenuItem<String>>((String customer) {
                return DropdownMenuItem<String>(
                  value: customer,
                  child: Text(customer),
                );
              }).toList(),
              onChanged: (String? newCustomer) {
                setState(() {
                  selectedCustomer = newCustomer;
                  customerNameController.text =
                      newCustomer ?? "Walk-in Customer";
                });
              },
            ),
            isCustomName
                ? TextField(
              controller: customerPhoneController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration:
              const InputDecoration(labelText: "Enter Customer Phone number",),
            ) : SizedBox(),
            const SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedTable,
              hint: Text(tableNameController.text),
              items: tables
                  .map<DropdownMenuItem<String>>((String customer) {
                return DropdownMenuItem<String>(
                  value: customer,
                  child: Text(customer),
                );
              }).toList(),
              onChanged: (String? newTable) {
                setState(() {
                  selectedTable = newTable;
                  tableNameController.text =
                      newTable ?? "Select a table";
                });
              },
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Save Invoice"),
          onPressed: () {
            Map<String, dynamic> invoiceData = {
              'customerName': customerNameController.text ?? '',
              'customerPhoneNumber': customerPhoneController.text ?? '',
              'table': selectedTable ?? '',
            };
            widget.onSubmit(invoiceData);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    customerNameController.dispose();
    receivedAmountController.dispose();
    partialAmountController.dispose();
    tableNameController.dispose();
    super.dispose();
  }
}
