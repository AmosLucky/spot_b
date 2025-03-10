import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

class PaymentForm extends StatefulWidget {
  final double subtotal;
  final SystemProvider systemProvider;
  final Function(Map<String, dynamic>) onSubmit;

  const PaymentForm(
      {super.key,
      required this.onSubmit,
      required this.subtotal,
      required this.systemProvider});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  List<String> customers = [];
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController receivedAmountController =
      TextEditingController();
  final TextEditingController partialAmountController = TextEditingController();

  String paymentType = 'Cash';
  String paymentStatus = 'Paid';
  double change = 0.0;
  String? selectedCustomer;
  bool isCustomName = false;

  @override
  void initState() {
    super.initState();
    customerNameController.text = "Walk-in Customer";
    _loadCustomers();
  }

  void _loadCustomers() async {
    var _customers = await getCustomers();
    if (mounted) {
      setState(() {
        customers = _customers;
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Payment"),
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
            const SizedBox(height: 10),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Amount to Pay ${Money.format(widget.subtotal)}",
                hintText: Money.format(widget.subtotal),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: receivedAmountController,
              decoration: const InputDecoration(labelText: "Received Amount"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double receivedAmount = double.tryParse(value) ?? 0.0;
                setState(() {
                  change = receivedAmount - widget.subtotal;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Payment Type: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: paymentType,
                  items: <String>['Cash', 'Transfer', 'POS']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      paymentType = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Payment Status: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: paymentStatus,
                  items: <String>['Paid', 'Unpaid', 'Partial']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      paymentStatus = newValue!;
                    });
                  },
                ),
              ],
            ),
            if (paymentStatus == 'Partial')
              TextField(
                controller: partialAmountController,
                decoration: const InputDecoration(labelText: "Partial Amount"),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 10),
            Text(
              "Change Return: ${Money.format(change)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
          child: const Text("Submit"),
          onPressed: () {
            double receivedAmount =
                double.tryParse(receivedAmountController.text) ?? 0.0;
            Map<String, dynamic> paymentData = {
              'customerName': customerNameController.text,
              'subtotal': widget.subtotal,
              'receivedAmount': receivedAmount,
              'paymentType': paymentType,
              'paymentStatus': paymentStatus,
              'change': change,
              'partialAmount': paymentStatus == 'Partial'
                  ? double.tryParse(partialAmountController.text) ?? 0.0
                  : null,
            };
            widget.onSubmit(paymentData);
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
    super.dispose();
  }
}
