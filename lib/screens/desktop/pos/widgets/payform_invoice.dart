import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/screens/desktop/pos/widgets/select_attendantdialog.dart';
import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_provider.dart';
import 'package:spotstock_inventory/screens/desktop/services/select_attendant_service.dart';
import '../../model/select_attendant_model.dart';
import '../dialogs/select_attendant_pin.dart';

class PayFormInvoice extends StatefulWidget {
  final SystemProvider systemProvider;
  Map data;
  final Function(Map<String, dynamic>) onSubmit;

  PayFormInvoice({
    super.key,
    required this.onSubmit,
    required this.data,
    required this.systemProvider,
  });

  @override
  State<PayFormInvoice> createState() => _PayFormInvoiceState();
}

class _PayFormInvoiceState extends State<PayFormInvoice> {
  SelectAttendantModel? _selectedAttendant;
  bool _attendantVerified = false;
  late SelectAttendantProvider _selectAttendantProvider;
  List<String> customers = [];
  List<String> tables = [];
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController tableNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
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
              .map((customer) => customer['attributes']['name'].toString())
              .toList();
          if (this.customers.isEmpty) {
            this.customers = ['Walk-in Customer'];
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading customers: $e');
      if (mounted) {
        setState(() {
          customers = ['Walk-in Customer'];
        });
      }
    }
  }

  void _loadTables() async {
    try {
      var tables = await widget.systemProvider.getTables();
      if (mounted) {
        setState(() {
          this.tables = tables
              .map((table) => table['attributes']['name'].toString())
              .toList();
        });
      }
    } catch (e) {
      debugPrint('Error loading tables: $e');
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
    if (attendant.hasPinSet) {
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
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CreatePinDialog(
          attendant: attendant,
          onPinCreated: () {
            setState(() {
              _selectedAttendant = attendant;
              _attendantVerified = false;
              _selectAttendantProvider.selectAttendant(attendant);
            });
            _promptForPin(SelectAttendantModel(
              apiId: attendant.apiId,
              firstName: attendant.firstName,
              lastName: attendant.lastName,
              email: attendant.email,
              phone: attendant.phone,
              department: attendant.department,
              hasPinSet: true,
            ));
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Disable customer input controls when attendant is verified
    bool isCustomerInputDisabled = _selectedAttendant != null && _attendantVerified;

    return AlertDialog(
      title: const Text("Hold Invoice"),
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
                      )
                    else if (_selectedAttendant != null && !_selectedAttendant!.hasPinSet)
                      TextButton(
                        onPressed: () => _promptForPin(_selectedAttendant!),
                        child: Text("Don't have a PIN? Create PIN"),
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
                  activeColor: isCustomerInputDisabled ? Colors.grey.shade400 : Colors.grey,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                  value: isCustomName,
                  onChanged: isCustomerInputDisabled
                      ? null
                      : (value) {
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
                    decoration: InputDecoration(
                      labelText: "Enter Customer Name",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: isCustomerInputDisabled
                            ? null
                            : () => customerNameController.clear(),
                      ),
                    ),
                    enabled: !isCustomerInputDisabled,
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
                    onChanged: isCustomerInputDisabled
                        ? null
                        : (String? newCustomer) {
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
                decoration: InputDecoration(
                  labelText: "Enter Customer Phone number",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: isCustomerInputDisabled
                        ? null
                        : () => customerPhoneController.clear(),
                  ),
                ),
                enabled: !isCustomerInputDisabled,
              ),
            const SizedBox(height: 10),
            // Table selection is always enabled
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
            // Validate inputs
            if (_selectedAttendant == null &&
                customerNameController.text.trim().isEmpty &&
                selectedCustomer == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select an attendant or provide a customer name'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            widget.data = {};
            Map<String, dynamic> invoiceData = {
              'customerName': customerNameController.text.trim().isNotEmpty
                  ? customerNameController.text.trim()
                  : selectedCustomer ?? "Walk-in Customer",
              'customerPhoneNumber': customerPhoneController.text,
              'table': selectedTable ?? tableNameController.text,
              'attendantId': _selectedAttendant?.apiId?.toString(),
              'attendantName': _selectedAttendant?.fullName,
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
    tableNameController.dispose();
    customerPhoneController.dispose();
    super.dispose();
  }
}



class CreatePinDialog extends StatefulWidget {
  final SelectAttendantModel attendant;
  final VoidCallback onPinCreated;

  const CreatePinDialog({
    super.key,
    required this.attendant,
    required this.onPinCreated,
  });

  @override
  State<CreatePinDialog> createState() => _CreatePinDialogState();
}

class _CreatePinDialogState extends State<CreatePinDialog> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  bool _isCreating = false;
  String? _errorMessage;

  void _createPin() async {
    setState(() {
      _isCreating = true;
      _errorMessage = null;
    });

    final pin = _pinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    if (pin.length != 6 || !RegExp(r'^\d+$').hasMatch(pin)) {
      setState(() {
        _isCreating = false;
        _errorMessage = 'PIN must be 6 digits';
      });
      return;
    }

    if (pin != confirmPin) {
      setState(() {
        _isCreating = false;
        _errorMessage = 'PINs do not match';
      });
      return;
    }

    try {
      final success = await SelectAttendantService().createPin(widget.attendant.apiId, pin);
      if (success) {
        setState(() {
          _isCreating = false;
        });
        Navigator.of(context).pop(); // Close CreatePinDialog
        widget.onPinCreated();

        // Create updated attendant model with hasPinSet: true
        final updatedAttendant = SelectAttendantModel(
          apiId: widget.attendant.apiId,
          firstName: widget.attendant.firstName,
          lastName: widget.attendant.lastName,
          email: widget.attendant.email,
          phone: widget.attendant.phone,
          department: widget.attendant.department,
          hasPinSet: true,
        );

        // Open SelectAttendantPinDialog to verify the new PIN
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SelectAttendantPinDialog(
            attendant: updatedAttendant,
            onPinVerified: (verified) {
              if (verified) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Welcome, ${updatedAttendant.fullName}!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invalid PIN entered'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PIN created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _isCreating = false;
          _errorMessage = 'Failed to create PIN';
        });
      }
    } catch (e) {
      setState(() {
        _isCreating = false;
        _errorMessage = 'Error creating PIN: $e';
      });
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create PIN for ${widget.attendant.fullName}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter new 6-digit PIN'),
            Gap(10),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'Enter PIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: ColorsRes.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: ColorsRes.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            Gap(10),
            const Text('Confirm PIN'),
            Gap(2),
            TextField(
              controller: _confirmPinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'Confirm PIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: ColorsRes.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: ColorsRes.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                errorText: _errorMessage,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isCreating ? null : _createPin,
          child: _isCreating
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/select_attendantdialog.dart';
// import '../../model/select_attendant_model.dart';
// import '../../providers/select_attendant_provider.dart';
// import '../../services/select_attendant_service.dart';
// import '../dialogs/select_attendant_pin.dart';
// // import 'package:spotstock_inventory/common/money.dart';

// class PayFormInvoice extends StatefulWidget {
//   final SystemProvider systemProvider;
//   final Map data;
//   final Function(Map<String, dynamic>) onSubmit;

//   const PayFormInvoice({
//     super.key,
//     required this.data,
//     required this.onSubmit,
//     required this.systemProvider,
//   });

//   @override
//   State<PayFormInvoice> createState() => _PayFormInvoiceState();
// }

// class _PayFormInvoiceState extends State<PayFormInvoice> {
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
//     customerPhoneController.text = widget.data['customerPhoneNumber'] ?? "";
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
//             _promptForPin(attendant);
//           },
//           previouslySelectedAttendant: _selectedAttendant,
//         ),
//       ),
//     );
//   }

//   void _promptForPin(SelectAttendantModel attendant) {
//     if (attendant.hasPinSet) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => SelectAttendantPinDialog(
//           attendant: attendant,
//           onPinVerified: (verified) {
//             setState(() {
//               _attendantVerified = verified;
//               if (!verified) {
//                 _selectedAttendant = null;
//                 _selectAttendantProvider.selectAttendant(null);
//               }
//             });

//             if (verified) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Welcome, ${attendant.fullName}!'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             }
//           },
//         ),
//       );
//     } else {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => CreatePinDialog(
//           attendant: attendant,
//           onPinCreated: () {
//             setState(() {
//               _selectedAttendant = attendant;
//               _attendantVerified = false;
//               _selectAttendantProvider.selectAttendant(attendant);
//             });
//             _promptForPin(SelectAttendantModel(
//               apiId: attendant.apiId,
//               firstName: attendant.firstName,
//               lastName: attendant.lastName,
//               email: attendant.email,
//               phone: attendant.phone,
//               department: attendant.department,
//               hasPinSet: true,
//             ));
//           },
//         ),
//       );
//     }
//   }

//   bool _validateForm() {
//     final customerName = customerNameController.text.trim();
//     final table = selectedTable?.trim();

//     if (table == null && customerName.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please select a table or enter customer details'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }

//     if (isCustomName && customerName.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter a customer name'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }

//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isCustomerInputDisabled = false;

//     return AlertDialog(
//       title: const Text("Invoice"),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Attendant (Optional)'),
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
//                           : Colors.grey,
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
//                       )
//                     else if (_selectedAttendant != null && !_selectedAttendant!.hasPinSet)
//                       TextButton(
//                         onPressed: () => _promptForPin(_selectedAttendant!),
//                         child: Text("Don't have a PIN? Create PIN"),
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
//                   onChanged: isCustomerInputDisabled
//                       ? null
//                       : (value) {
//                           setState(() {
//                             isCustomName = value;
//                             if (!isCustomName) {
//                               customerNameController.text = selectedCustomer ?? "Walk-in Customer";
//                             } else {
//                               customerNameController.clear();
//                             }
//                           });
//                         },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             isCustomName
//                 ? TextField(
//                     controller: customerNameController,
//                     decoration: const InputDecoration(labelText: "Enter Customer Name"),
//                     enabled: !isCustomerInputDisabled,
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
//                     onChanged: isCustomerInputDisabled
//                         ? null
//                         : (String? newCustomer) {
//                             setState(() {
//                               selectedCustomer = newCustomer;
//                               customerNameController.text = newCustomer ?? "Walk-in Customer";
//                             });
//                           },
//                   ),
//             if (isCustomName)
//               TextField(
//                 controller: customerPhoneController,
//                 keyboardType: TextInputType.numberWithOptions(),
//                 decoration: const InputDecoration(
//                   labelText: "Enter Customer Phone number (Optional)",
//                 ),
//                 enabled: !isCustomerInputDisabled,
//               ),
//             const SizedBox(height: 10),
//             DropdownButton<String>(
//               isExpanded: true,
//               value: selectedTable,
//               hint: Text(tableNameController.text),
//               items: tables.map<DropdownMenuItem<String>>((String table) {
//                 return DropdownMenuItem<String>(
//                   value: table,
//                   child: Text(table),
//                 );
//               }).toList(),
//               onChanged: (String? newTable) {
//                 setState(() {
//                   selectedTable = newTable;
//                   tableNameController.text = newTable ?? "Select a table";
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text("Cancel"),
//           onPressed: () {
//             widget.data.clear();
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text("Save Invoice"),
//           onPressed: () {
//             if (!_validateForm()) {
//               return;
//             }
//             Map<String, dynamic> invoiceData = {
//               'customerName': customerNameController.text,
//               'customerPhoneNumber': customerPhoneController.text,
//               'table': selectedTable,
//               'attendantId': _selectedAttendant?.apiId?.toString(),
//               // 'attendantId': _selectedAttendant?.id,
//             };
//             widget.onSubmit(invoiceData);
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

// class CreatePinDialog extends StatefulWidget {
//   final SelectAttendantModel attendant;
//   final VoidCallback onPinCreated;

//   const CreatePinDialog({
//     super.key,
//     required this.attendant,
//     required this.onPinCreated,
//   });

//   @override
//   State<CreatePinDialog> createState() => _CreatePinDialogState();
// }

// class _CreatePinDialogState extends State<CreatePinDialog> {
//   final TextEditingController _pinController = TextEditingController();
//   final TextEditingController _confirmPinController = TextEditingController();
//   bool _isCreating = false;
//   String? _errorMessage;

//   void _createPin() async {
//     setState(() {
//       _isCreating = true;
//       _errorMessage = null;
//     });

//     final pin = _pinController.text.trim();
//     final confirmPin = _confirmPinController.text.trim();

//     if (pin.length != 6 || !RegExp(r'^\d+$').hasMatch(pin)) {
//       setState(() {
//         _isCreating = false;
//         _errorMessage = 'PIN must be 6 digits';
//       });
//       return;
//     }

//     if (pin != confirmPin) {
//       setState(() {
//         _isCreating = false;
//         _errorMessage = 'PINs do not match';
//       });
//       return;
//     }

//     try {
//       final success = await SelectAttendantService().createPin(widget.attendant.apiId, pin);
//       if (success) {
//         setState(() {
//           _isCreating = false;
//         });
//         Navigator.of(context).pop(); // Close CreatePinDialog
//         widget.onPinCreated();

//         // Create updated attendant model with hasPinSet: true
//         final updatedAttendant = SelectAttendantModel(
//           apiId: widget.attendant.apiId,
//           firstName: widget.attendant.firstName,
//           lastName: widget.attendant.lastName,
//           email: widget.attendant.email,
//           phone: widget.attendant.phone,
//           department: widget.attendant.department,
//           hasPinSet: true,
//         );

//         // Open SelectAttendantPinDialog to verify the new PIN
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) => SelectAttendantPinDialog(
//             attendant: updatedAttendant,
//             onPinVerified: (verified) {
//               if (verified) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Welcome, ${updatedAttendant.fullName}!'),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Invalid PIN entered'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//           ),
//         );

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('PIN created successfully'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         setState(() {
//           _isCreating = false;
//           _errorMessage = 'Failed to create PIN';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isCreating = false;
//         _errorMessage = 'Error creating PIN: $e';
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _pinController.dispose();
//     _confirmPinController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Create PIN for ${widget.attendant.fullName}'),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Enter new 6-digit PIN'),
//             Gap(10),
//             TextField(
//               controller: _pinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: 'Enter PIN',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: ColorsRes.grey),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: ColorsRes.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               ),
//             ),
//             Gap(10),
//             const Text('Confirm PIN'),
//             Gap(2),
//             TextField(
//               controller: _confirmPinController,
//               keyboardType: TextInputType.number,
//               obscureText: true,
//               maxLength: 6,
//               decoration: InputDecoration(
//                 hintText: 'Confirm PIN',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: ColorsRes.grey),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: ColorsRes.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: const BorderSide(color: Colors.blue),
//                 ),
//                 errorText: _errorMessage,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: _isCreating ? null : _createPin,
//           child: _isCreating
//               ? const SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 )
//               : const Text('Create'),
//         ),
//       ],
//     );
//   }
// }