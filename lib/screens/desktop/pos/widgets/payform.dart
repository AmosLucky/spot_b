import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/select_attendantdialog.dart';
import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_provider.dart';
import '../../model/select_attendant_model.dart';
import '../dialogs/select_attendant_pin.dart';

class PaymentForm extends StatefulWidget {
  final String app;
  final double subtotal;
  final SystemProvider systemProvider;
  Map data;
  bool isInvoice;
  final Function(Map<String, dynamic>) onSubmit;

  PaymentForm({
    super.key,
    required this.onSubmit,
    required this.subtotal,
    required this.app,
    required this.data,
    required this.isInvoice,
    required this.systemProvider,
  });

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  SelectAttendantModel? _selectedAttendant;
  bool _attendantVerified = false;
  late SelectAttendantProvider _selectAttendantProvider;
  List<String> customers = [];
  List<String> tables = [];
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController receivedAmountController = TextEditingController();
  final TextEditingController partialAmountController = TextEditingController();
  final TextEditingController tableNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();

  String paymentType = 'Cash';
  String paymentStatus = 'Paid';
  double change = 0.0;
  String? selectedCustomer;
  String? selectedTable;
  bool isCustomName = false;

  @override
  void initState() {
    super.initState();
    isCustomName = widget.data['customerName'] != null;
    customerNameController.text = widget.data['customerName'] ?? "Walk-in Customer";
    tableNameController.text = widget.data['table'] ?? "Select a table";
    customerPhoneController.text = widget.data['customerPhoneNumber'] ?? "";
    _loadCustomers();
    _loadTables();
    _selectAttendantProvider = Provider.of<SelectAttendantProvider>(context, listen: false);
    _selectAttendantProvider.loadAttendants();
  }

  void _loadCustomers() async {
    try {
      var customers = await widget.systemProvider.getCustomers();
      if (mounted) {
        setState(() {
          this.customers = customers
              .map((customer) => customer['attributes']['name'] as String)
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching customers: $e');
    }
  }

  void _loadTables() async {
    try {
      var tables = await widget.systemProvider.getTables();
      if (mounted) {
        setState(() {
          this.tables = tables
              .map((customer) => customer['attributes']['name'] as String)
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching tables: $e');
    }
  }

  void _selectAttendant() {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _selectAttendantProvider,
        child: SelectAttendantDialog(
          onAttendantSelected: (attendant) {
            setState(() {
              _selectedAttendant = attendant;
              _attendantVerified = false;
              _selectAttendantProvider.selectAttendant(attendant);
            });
            _promptForPin(attendant);
          },
          previouslySelectedAttendant: _selectedAttendant,
        ),
      ),
    );
  }

  void _promptForPin(SelectAttendantModel attendant) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SelectAttendantPinDialog(
        attendant: attendant,
        onPinVerified: (verified) {
          setState(() {
            _attendantVerified = verified;
            if (!verified) {
              _selectedAttendant = null;
              _selectAttendantProvider.selectAttendant(null);
            }
          });

          if (verified) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome, ${attendant.fullName}!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Payment"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attendant'),
            Gap(3),
            GestureDetector(
              onTap: _attendantVerified ? null : _selectAttendant,
              child: Container(
                height: 40,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorsRes.grey),
                  color: _selectedAttendant != null && _attendantVerified
                      ? Colors.green.shade50
                      : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      _selectedAttendant != null && _attendantVerified
                          ? Icons.check_circle
                          : Icons.person,
                      color: _selectedAttendant != null && _attendantVerified
                          ? Colors.green
                          : ColorsRes.grey,
                      size: 20,
                    ),
                    Text(
                      _selectedAttendant != null
                          ? '${_selectedAttendant!.fullName} ${_attendantVerified ? '(Verified)' : '(Not Verified)'}'
                          : 'Select Attendant',
                      style: TextStyle(
                        color: _selectedAttendant != null && _attendantVerified
                            ? Colors.green.shade700
                            : Colors.black,
                        fontWeight: _selectedAttendant != null && _attendantVerified
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    if (_selectedAttendant != null && _attendantVerified)
                      TextButton(
                        onPressed: _selectAttendant,
                        child: Text('Edit'),
                      ),
                  ],
                ),
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Customer: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                  activeColor: Colors.grey,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                  value: isCustomName,
                  onChanged: (value) {
                    setState(() {
                      isCustomName = value;
                      if (!isCustomName) {
                        customerNameController.text = selectedCustomer ?? "Walk-in Customer";
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
                    decoration: const InputDecoration(labelText: "Enter Customer Name"),
                  )
                : DropdownButton<String>(
                    isExpanded: true,
                    value: selectedCustomer,
                    hint: Text(customerNameController.text),
                    items: customers.map<DropdownMenuItem<String>>((String customer) {
                      return DropdownMenuItem<String>(
                        value: customer,
                        child: Text(customer),
                      );
                    }).toList(),
                    onChanged: (String? newCustomer) {
                      setState(() {
                        selectedCustomer = newCustomer;
                        customerNameController.text = newCustomer ?? "Walk-in Customer";
                      });
                    },
                  ),
            if (isCustomName)
              TextField(
                controller: customerPhoneController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: "Enter Customer Phone number",
                ),
              ),
            const SizedBox(height: 10),
            if (widget.app == 'pos')
              DropdownButton<String>(
                isExpanded: true,
                value: selectedTable,
                hint: Text(tableNameController.text),
                items: tables.map<DropdownMenuItem<String>>((String table) {
                  return DropdownMenuItem<String>(
                    value: table,
                    child: Text(table),
                  );
                }).toList(),
                onChanged: (String? newTable) {
                  setState(() {
                    selectedTable = newTable;
                    tableNameController.text = newTable ?? "Select a table";
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
            if (widget.app == 'pos')
              Row(
                children: [
                  const Text("Payment Type: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
            if (widget.app == 'pos')
              Row(
                children: [
                  const Text("Payment Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
            widget.data = {};
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Submit"),
          onPressed: () {
            if (_selectedAttendant == null || !_attendantVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select and verify an attendant'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            widget.data = {};
            double receivedAmount = double.tryParse(receivedAmountController.text) ?? 0.0;
            Map<String, dynamic> paymentData = {
              'customerName': customerNameController.text,
              'customerPhoneNumber': customerPhoneController.text,
              'subtotal': widget.subtotal,
              'receivedAmount': receivedAmount,
              'paymentType': paymentType,
              'paymentStatus': paymentStatus,
              'change': change,
              'partialAmount': paymentStatus == 'Partial'
                  ? double.tryParse(partialAmountController.text) ?? 0.0
                  : null,
              'table': selectedTable,
              'attendantId': _selectedAttendant?.id,
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
    tableNameController.dispose();
    customerPhoneController.dispose();
    super.dispose();
  }
}



// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/attendant_pin.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/select_attendantdialog.dart';
// // import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_model.dart';
// import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_provider.dart';

// import '../../model/select_attendant_model.dart';
// import '../dialogs/select_attendant_pin.dart';

// class PaymentForm extends StatefulWidget {
//   final String app;
//   final double subtotal;
//   final SystemProvider systemProvider;
//   Map data;
//   bool isInvoice;
//   final Function(Map<String, dynamic>) onSubmit;

//   PaymentForm({
//     super.key,
//     required this.onSubmit,
//     required this.subtotal,
//     required this.app,
//     required this.data,
//     required this.isInvoice,
//     required this.systemProvider,
//   });

//   @override
//   State<PaymentForm> createState() => _PaymentFormState();
// }

// class _PaymentFormState extends State<PaymentForm> {
//   SelectAttendantModel? _selectedAttendant;
//   bool _attendantVerified = false;
//   late SelectAttendantProvider _selectAttendantProvider;
//   List<String> customers = [];
//   List<String> tables = [];
//   final TextEditingController customerNameController = TextEditingController();
//   final TextEditingController receivedAmountController = TextEditingController();
//   final TextEditingController partialAmountController = TextEditingController();
//   final TextEditingController tableNameController = TextEditingController();
//   final TextEditingController customerPhoneController = TextEditingController();

//   String paymentType = 'Cash';
//   String paymentStatus = 'Paid';
//   double change = 0.0;
//   String? selectedCustomer;
//   String? selectedTable;
//   bool isCustomName = false;

//   @override
//   void initState() {
//     super.initState();
//     isCustomName = widget.data['customerName'] != null;
//     customerNameController.text = widget.data['customerName'] ?? "Walk-in Customer";
//     tableNameController.text = widget.data['table'] ?? "Select a table";
//     customerPhoneController.text = widget.data['customerPhoneNumber'] ?? "Enter phone number";
//     _loadCustomers();
//     _loadTables();
//     _selectAttendantProvider = Provider.of<SelectAttendantProvider>(context, listen: false);
//     _selectAttendantProvider.loadAttendants();
//   }

//   void _loadCustomers() async {
//     try {
//       var customers = await widget.systemProvider.getCustomers();
//       if (mounted) {
//         setState(() {
//           this.customers = customers
//               .map((customer) => customer['attributes']['name'] as String)
//               .toList();
//         });
//       }
//     } catch (e) {
//       print('Error fetching customers: $e');
//     }
//   }

//   void _loadTables() async {
//     try {
//       var tables = await widget.systemProvider.getTables();
//       if (mounted) {
//         setState(() {
//           this.tables = tables
//               .map((customer) => customer['attributes']['name'] as String)
//               .toList();
//         });
//       }
//     } catch (e) {
//       print('Error fetching tables: $e');
//     }
//   }

//   void _selectAttendant() {
//     showDialog(
//       context: context,
//       builder: (context) => ChangeNotifierProvider.value(
//         value: _selectAttendantProvider,
//         child: SelectAttendantDialog(
//           onAttendantSelected: (attendant) {
//             setState(() {
//               _selectedAttendant = attendant;
//               _attendantVerified = false;
//               _selectAttendantProvider.selectAttendant(attendant);
//             });

//             if (attendant.hasPinSet) {
//               _promptForPin(attendant);
//             } else {
//               setState(() {
//                 _attendantVerified = true;
//               });
//             }
//           },
//           previouslySelectedAttendant: _selectedAttendant,
//         ),
//       ),
//     );
//   }

//   void _promptForPin(SelectAttendantModel attendant) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => SelectAttendantPinDialog(
//         attendant: attendant,
//         onPinVerified: (verified) {
//           setState(() {
//             _attendantVerified = verified;
//             if (!verified) {
//               _selectedAttendant = null;
//               _selectAttendantProvider.selectAttendant(null);
//             }
//           });

//           if (verified) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Welcome, ${attendant.fullName}!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Payment"),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Attendant'),
//             Gap(3),
//             GestureDetector(
//               onTap: _attendantVerified ? null : _selectAttendant,
//               child: Container(
//                 height: 40,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: ColorsRes.grey),
//                   color: _selectedAttendant != null && _attendantVerified
//                       ? Colors.green.shade50
//                       : Colors.white,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(
//                       _selectedAttendant != null && _attendantVerified
//                           ? Icons.check_circle
//                           : Icons.person,
//                       color: _selectedAttendant != null && _attendantVerified
//                           ? Colors.green
//                           : ColorsRes.grey,
//                       size: 20,
//                     ),
//                     Text(
//                       _selectedAttendant != null
//                           ? '${_selectedAttendant!.fullName} ${_attendantVerified ? '(Verified)' : '(Not Verified)'}'
//                           : 'Select Attendant',
//                       style: TextStyle(
//                         color: _selectedAttendant != null && _attendantVerified
//                             ? Colors.green.shade700
//                             : Colors.black,
//                         fontWeight: _selectedAttendant != null && _attendantVerified
//                             ? FontWeight.w600
//                             : FontWeight.normal,
//                       ),
//                     ),
//                     if (_selectedAttendant != null && _attendantVerified)
//                       TextButton(
//                         onPressed: _selectAttendant,
//                         child: Text('Edit'),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             Gap(10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Customer: ", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Switch(
//                   activeColor: Colors.grey,
//                   inactiveThumbColor: Colors.grey,
//                   inactiveTrackColor: Colors.grey[300],
//                   value: isCustomName,
//                   onChanged: (value) {
//                     setState(() {
//                       isCustomName = value;
//                       if (!isCustomName) {
//                         customerNameController.text = selectedCustomer ?? "Walk-in Customer";
//                       } else {
//                         customerNameController.clear();
//                       }
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             isCustomName
//                 ? TextField(
//                     controller: customerNameController,
//                     decoration: const InputDecoration(labelText: "Enter Customer Name"),
//                   )
//                 : DropdownButton<String>(
//                     isExpanded: true,
//                     value: selectedCustomer,
//                     hint: Text(customerNameController.text),
//                     items: customers.map<DropdownMenuItem<String>>((String customer) {
//                       return DropdownMenuItem<String>(
//                         value: customer,
//                         child: Text(customer),
//                       );
//                     }).toList(),
//                     onChanged: (String? newCustomer) {
//                       setState(() {
//                         selectedCustomer = newCustomer;
//                         customerNameController.text = newCustomer ?? "Walk-in Customer";
//                       });
//                     },
//                   ),
//             if (isCustomName)
//               TextField(
//                 controller: customerPhoneController,
//                 keyboardType: TextInputType.numberWithOptions(),
//                 decoration: const InputDecoration(
//                   labelText: "Enter Customer Phone number",
//                 ),
//               ),
//             const SizedBox(height: 10),
//             if (widget.app == 'pos')
//               DropdownButton<String>(
//                 isExpanded: true,
//                 value: selectedTable,
//                 hint: Text(tableNameController.text),
//                 items: tables.map<DropdownMenuItem<String>>((String table) {
//                   return DropdownMenuItem<String>(
//                     value: table,
//                     child: Text(table),
//                   );
//                 }).toList(),
//                 onChanged: (String? newTable) {
//                   setState(() {
//                     selectedTable = newTable;
//                     tableNameController.text = newTable ?? "Select a table";
//                   });
//                 },
//               ),
//             const SizedBox(height: 10),
//             TextField(
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: "Amount to Pay ${Money.format(widget.subtotal)}",
//                 hintText: Money.format(widget.subtotal),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: receivedAmountController,
//               decoration: const InputDecoration(labelText: "Received Amount"),
//               keyboardType: TextInputType.number,
//               onChanged: (value) {
//                 double receivedAmount = double.tryParse(value) ?? 0.0;
//                 setState(() {
//                   change = receivedAmount - widget.subtotal;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             if (widget.app == 'pos')
//               Row(
//                 children: [
//                   const Text("Payment Type: ", style: TextStyle(fontWeight: FontWeight.bold)),
//                   DropdownButton<String>(
//                     value: paymentType,
//                     items: <String>['Cash', 'Transfer', 'POS']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         paymentType = newValue!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             const SizedBox(height: 10),
//             if (widget.app == 'pos')
//               Row(
//                 children: [
//                   const Text("Payment Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
//                   DropdownButton<String>(
//                     value: paymentStatus,
//                     items: <String>['Paid', 'Unpaid', 'Partial']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         paymentStatus = newValue!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             if (paymentStatus == 'Partial')
//               TextField(
//                 controller: partialAmountController,
//                 decoration: const InputDecoration(labelText: "Partial Amount"),
//                 keyboardType: TextInputType.number,
//               ),
//             const SizedBox(height: 10),
//             Text(
//               "Change Return: ${Money.format(change)}",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text("Cancel"),
//           onPressed: () {
//             widget.data = {};
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: const Text("Submit"),
//           onPressed: () {
//             if (_selectedAttendant == null || !_attendantVerified) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Please select and verify an attendant'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//               return;
//             }
//             widget.data = {};
//             double receivedAmount = double.tryParse(receivedAmountController.text) ?? 0.0;
//             Map<String, dynamic> paymentData = {
//               'customerName': customerNameController.text,
//               'customerPhoneNumber': customerPhoneController.text,
//               'subtotal': widget.subtotal,
//               'receivedAmount': receivedAmount,
//               'paymentType': paymentType,
//               'paymentStatus': paymentStatus,
//               'change': change,
//               'partialAmount': paymentStatus == 'Partial'
//                   ? double.tryParse(partialAmountController.text) ?? 0.0
//                   : null,
//               'table': selectedTable,
//               'attendantId': _selectedAttendant?.id,
//             };
//             widget.onSubmit(paymentData);
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     customerNameController.dispose();
//     receivedAmountController.dispose();
//     partialAmountController.dispose();
//     tableNameController.dispose();
//     customerPhoneController.dispose();
//     super.dispose();
//   }
// }