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
import 'payform_invoice.dart';

class PaymentForm extends StatefulWidget {
  final String app;
  final double subtotal;
  final SystemProvider systemProvider;
  Map data;
  bool isInvoice;
  final Function(Map<String, dynamic>) onSubmit;
  
  // Add cart items for order summary
  final List<dynamic>? cartItems;
  final double tax;
  final double discount;
  final double shipping;

  PaymentForm({
    super.key,
    required this.onSubmit,
    required this.subtotal,
    required this.app,
    required this.data,
    required this.isInvoice,
    required this.systemProvider,
    this.cartItems,
    this.tax = 0.0,
    this.discount = 0.0,
    this.shipping = 0.0,
  });

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  SelectAttendantModel? _selectedAttendant;
  bool _attendantVerified = false;
  late SelectAttendantProvider _selectAttendantProvider;
  
  // Payment method management
  List<String> _selectedPaymentMethods = ['Cash'];
  Map<String, TextEditingController> _methodAmountControllers = {};
  
  // Available payment methods
  final List<Map<String, dynamic>> _paymentMethods = [
    {'id': 'Cash', 'name': 'Cash', 'isActive': true},
    {'id': 'POS', 'name': 'Credit/Debit Card', 'isActive': true},
    {'id': 'Transfer', 'name': 'Bank Transfer', 'isActive': true},
    {'id': 'Folio', 'name': 'Folio', 'isActive': true},
    {'id': 'Compliment', 'name': 'Compliment', 'isActive': true},
    {'id': 'Other', 'name': 'Other', 'isActive': true},
  ];

  List<String> customers = [];
  List<String> tables = [];
  
  // Folio payment state
  List<dynamic> _activeBookings = [];
  Map<String, dynamic>? _selectedBooking;
  Map<String, dynamic>? _selectedRoom;
  bool _loadingBookings = false;

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController receivedAmountController = TextEditingController();
  final TextEditingController partialAmountController = TextEditingController();
  final TextEditingController tableNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController changeController = TextEditingController();

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
    
    // Initialize payment method controllers
    _initializePaymentControllers();
    
    _loadCustomers();
    _loadTables();
    _selectAttendantProvider = Provider.of<SelectAttendantProvider>(context, listen: false);
    _selectAttendantProvider.loadAttendants();
  }

  void _initializePaymentControllers() {
    _methodAmountControllers['Cash'] = TextEditingController(
      text: widget.subtotal.toStringAsFixed(2)
    );
    receivedAmountController.text = widget.subtotal.toStringAsFixed(2);
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

  void _loadActiveBookings() async {
    if (!_selectedPaymentMethods.contains('Folio')) return;
    
    setState(() {
      _loadingBookings = true;
    });

    try {
      // This would need to be implemented in your SystemProvider
      // var bookings = await widget.systemProvider.getActiveBookings();
      // For now, using mock data structure
      var bookings = []; // Replace with actual API call
      
      setState(() {
        _activeBookings = bookings;
        _loadingBookings = false;
      });
    } catch (e) {
      setState(() {
        _loadingBookings = false;
      });
      debugPrint('Error loading bookings: $e');
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

  void _addPaymentMethod(String methodId) {
    if (_selectedPaymentMethods.contains(methodId)) return;
    
    setState(() {
      _selectedPaymentMethods.add(methodId);
      
      // Calculate remaining amount
      double existingTotal = _methodAmountControllers.values
          .fold(0.0, (sum, controller) => sum + (double.tryParse(controller.text) ?? 0.0));
      
      double remaining = widget.subtotal - existingTotal;
      if (remaining < 0) remaining = 0.0;
      
      _methodAmountControllers[methodId] = TextEditingController(
        text: remaining.toStringAsFixed(2)
      );
      
      // Load bookings if Folio is selected
      if (methodId == 'Folio') {
        _loadActiveBookings();
      }
    });
  }

  void _removePaymentMethod(String methodId) {
    if (_selectedPaymentMethods.length <= 1) return; // Keep at least one method
    
    setState(() {
      _selectedPaymentMethods.remove(methodId);
      _methodAmountControllers[methodId]?.dispose();
      _methodAmountControllers.remove(methodId);
      
      if (methodId == 'Folio') {
        _selectedBooking = null;
        _selectedRoom = null;
      }
    });
  }

  void _calculateChange() {
    double totalPaid = _methodAmountControllers.values
        .fold(0.0, (sum, controller) => sum + (double.tryParse(controller.text) ?? 0.0));
    
    setState(() {
      change = totalPaid > widget.subtotal ? totalPaid - widget.subtotal : 0.0;
      changeController.text = change > 0 ? change.toStringAsFixed(2) : '';
    });
  }

  Widget _buildPaymentMethodTags() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ..._selectedPaymentMethods.map((methodId) {
            final method = _paymentMethods.firstWhere((m) => m['id'] == methodId);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(method['name'], style: TextStyle(fontSize: 12)),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _removePaymentMethod(methodId),
                    child: Icon(Icons.close, size: 16),
                  ),
                ],
              ),
            );
          }).toList(),
          // Add Method Dropdown
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text('+ Add Method', style: TextStyle(fontSize: 12)),
                items: _paymentMethods
                    .where((method) => method['isActive'] && !_selectedPaymentMethods.contains(method['id']))
                    .map((method) => DropdownMenuItem<String>(
                      value: method['id'],
                      child: Text(method['name']),
                    ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _addPaymentMethod(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFolioPaymentDetails(String methodId) {
    if (methodId != 'Folio') return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Folio Payment Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 12),
          if (_loadingBookings)
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text('Loading bookings...', style: TextStyle(fontSize: 12)),
                ],
              ),
            )
          else if (_activeBookings.isEmpty)
            Center(
              child: Column(
                children: [
                  Text('No active bookings found', style: TextStyle(fontSize: 12)),
                  TextButton(
                    onPressed: _loadActiveBookings,
                    child: Text('Refresh bookings', style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            )
          else ...[
            // Booking Selection
            Text('Select Booking:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            SizedBox(height: 4),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
              ),
              hint: Text('Select a booking...', style: TextStyle(fontSize: 12)),
              value: _selectedBooking?['id']?.toString(),
              items: _activeBookings.map((booking) => DropdownMenuItem<String>(
                value: booking['id'].toString(),
                child: Text(
                  '${booking['booking_number']} - ${booking['customer_name']} (Balance: ₦${booking['folio_balance']?.toStringAsFixed(2) ?? '0.00'})',
                  style: TextStyle(fontSize: 12),
                ),
              )).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedBooking = _activeBookings.firstWhere((b) => b['id'].toString() == value);
                    _selectedRoom = null;
                  });
                }
              },
            ),
            
            // Room Selection
            if (_selectedBooking != null && _selectedBooking!['booked_rooms'] != null) ...[
              SizedBox(height: 12),
              Text('Select Room:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                ),
                hint: Text('Select a room...', style: TextStyle(fontSize: 12)),
                value: _selectedRoom?['room_id']?.toString(),
                items: (_selectedBooking!['booked_rooms'] as List).map((room) => DropdownMenuItem<String>(
                  value: room['room_id'].toString(),
                  child: Text(room['room_name'], style: TextStyle(fontSize: 12)),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedRoom = (_selectedBooking!['booked_rooms'] as List)
                          .firstWhere((r) => r['room_id'].toString() == value);
                    });
                  }
                },
              ),
            ],
            
            // Booking Info
            if (_selectedBooking != null) ...[
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Guest:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                        Text(_selectedBooking!['customer_name'] ?? '', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Balance:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                        Text(
                          '₦${_selectedBooking!['folio_balance']?.toStringAsFixed(2) ?? '0.00'}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: (_selectedBooking!['folio_balance'] ?? 0) >= (double.tryParse(_methodAmountControllers['Folio']?.text ?? '0') ?? 0)
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    int totalProducts = widget.cartItems?.fold(0, (sum, item) => sum! + (item['quantity'] as int? ?? 0)) ?? 0;
    double subtotal = widget.cartItems?.fold(0.0, (sum, item) => sum! + (item['subTotal'] as double? ?? 0.0)) ?? 0.0;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSummaryRow('Total Products', totalProducts.toString(), isCount: true),
                _buildSummaryRow('Subtotal', Money.format(subtotal)),
                _buildSummaryRow('Order Tax', '${Money.format(widget.tax)} (${widget.tax > 0 ? (widget.tax / subtotal * 100).toStringAsFixed(2) : '0'}%)'),
                _buildSummaryRow('Discount', Money.format(widget.discount)),
                _buildSummaryRow('Shipping', Money.format(widget.shipping)),
                if (_selectedAttendant != null)
                  _buildSummaryRow('Attendant', _selectedAttendant!.fullName),
                Divider(),
                _buildSummaryRow('Grand Total', Money.format(widget.subtotal), isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isCount = false, bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isCount)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isCustomerInputDisabled = _selectedAttendant != null && _attendantVerified;

    return AlertDialog(
      title: Text("Make Payment"),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Payment Details
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Attendant Selection
                    Text('Attendant', style: TextStyle(fontWeight: FontWeight.bold)),
                    Gap(8),
                    GestureDetector(
                      onTap: _attendantVerified ? null : _selectAttendant,
                      child: Container(
                        height: 48,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                            Expanded(
                              child: Text(
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
                    Gap(16),

                    // Total Amount and Change
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
                              Gap(4),
                              TextField(
                                controller: TextEditingController(text: Money.format(widget.subtotal)),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Change to give to customer:', style: TextStyle(fontWeight: FontWeight.bold)),
                              Gap(4),
                              TextField(
                                controller: changeController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  hintText: '0.00',
                                ),
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(16),

                    // Payment Type Selection (only for Paid/Partial status)
                    if (paymentStatus != 'Unpaid') ...[
                      Text('Payment Type:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Gap(8),
                      _buildPaymentMethodTags(),
                      Gap(16),
                    ],

                    // Payment Amounts (only for Paid/Partial status)
                    if (paymentStatus != 'Unpaid') ...[
                      ..._selectedPaymentMethods.map((methodId) {
                        final method = _paymentMethods.firstWhere((m) => m['id'] == methodId);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${method['name']} Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Gap(4),
                            TextField(
                              controller: _methodAmountControllers[methodId],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                hintText: widget.subtotal.toStringAsFixed(2),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => _calculateChange(),
                            ),
                            _buildFolioPaymentDetails(methodId),
                            Gap(16),
                          ],
                        );
                      }).toList(),
                    ],

                    // Customer Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Customer: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Gap(8),
                    isCustomName
                        ? TextField(
                            controller: customerNameController,
                            decoration: InputDecoration(
                              labelText: "Enter Customer Name",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: isCustomerInputDisabled
                                    ? null
                                    : () => customerNameController.clear(),
                              ),
                            ),
                            enabled: !isCustomerInputDisabled,
                          )
                        : DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
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
                    
                    if (isCustomName) ...[
                      Gap(16),
                      TextField(
                        controller: customerPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Enter Customer Phone number",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: isCustomerInputDisabled
                                ? null
                                : () => customerPhoneController.clear(),
                          ),
                        ),
                        enabled: !isCustomerInputDisabled,
                      ),
                    ],
                    Gap(16),

                    // Table Selection
                    if (widget.app == 'pos') ...[
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Select Table",
                          border: OutlineInputBorder(),
                        ),
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
                      Gap(16),
                    ],

                    // Payment Status
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Payment Status",
                        border: OutlineInputBorder(),
                      ),
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
                          if (paymentStatus == 'Unpaid') {
                            // Reset payment methods for unpaid
                            if (_selectedPaymentMethods.isNotEmpty) {
                              String firstMethod = _selectedPaymentMethods.first;
                              _methodAmountControllers[firstMethod]?.text = '0.00';
                            }
                          } else if (paymentStatus == 'Paid') {
                            // Set full amount for paid
                            if (_selectedPaymentMethods.isNotEmpty) {
                              String firstMethod = _selectedPaymentMethods.first;
                              _methodAmountControllers[firstMethod]?.text = widget.subtotal.toStringAsFixed(2);
                            }
                          }
                          _calculateChange();
                        });
                      },
                    ),
                    
                    if (paymentStatus == 'Unpaid') ...[
                      Gap(8),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade50,
                          border: Border.all(color: Colors.yellow.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Unpaid status will create a sale with no payment. Customer will need to pay later.',
                          style: TextStyle(
                            color: Colors.yellow.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],

                    if (paymentStatus == 'Partial') ...[
                      Gap(16),
                      TextField(
                        controller: partialAmountController,
                        decoration: InputDecoration(
                          labelText: "Partial Amount",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            SizedBox(width: 24),
            
            // Right Column - Order Summary
            Expanded(
              flex: 1,
              child: _buildOrderSummary(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            widget.data = {};
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Submit"),
          onPressed: () {
            // Validation
            if (_selectedAttendant == null &&
                customerNameController.text.trim().isEmpty &&
                selectedCustomer == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select an attendant or provide a customer name'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Folio payment validation
            if (_selectedPaymentMethods.contains('Folio')) {
              double folioAmount = double.tryParse(_methodAmountControllers['Folio']?.text ?? '0') ?? 0.0;
              if (folioAmount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid folio amount')),
                );
                return;
              }
              if (_selectedBooking == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a booking for folio payment')),
                );
                return;
              }
              if (_selectedRoom == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select a room for folio payment')),
                );
                return;
              }
            }

            double receivedAmount = _methodAmountControllers.values
                .fold(0.0, (sum, controller) => sum + (double.tryParse(controller.text) ?? 0.0));
            
            if (receivedAmount < 0 || (paymentStatus == 'Partial' && (double.tryParse(partialAmountController.text) ?? 0.0) <= 0)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid amount entered'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            widget.data = {};
            Map<String, dynamic> paymentData = {
              'customerName': customerNameController.text.trim().isNotEmpty
                  ? customerNameController.text.trim()
                  : selectedCustomer ?? "Walk-in Customer",
              'customerPhoneNumber': customerPhoneController.text,
              'subtotal': widget.subtotal,
              'receivedAmount': receivedAmount,
              'paymentType': _selectedPaymentMethods.first, // Primary payment method
              'paymentMethods': _selectedPaymentMethods,
              'methodAmounts': _methodAmountControllers.map((key, controller) => 
                  MapEntry(key, double.tryParse(controller.text) ?? 0.0)),
              'paymentStatus': paymentStatus,
              'change': change,
              'partialAmount': paymentStatus == 'Partial'
                  ? double.tryParse(partialAmountController.text) ?? 0.0
                  : null,
              'table': selectedTable,
              'attendantId': _selectedAttendant?.apiId?.toString(),
              'attendantName': _selectedAttendant?.fullName,
              // Folio-specific data
              if (_selectedPaymentMethods.contains('Folio') && _selectedBooking != null && _selectedRoom != null)
                'room_type': {
                  'booking_id': _selectedBooking!['id'],
                  'room_id': _selectedRoom!['room_id'],
                },
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
    changeController.dispose();
    
    // Dispose payment method controllers
    _methodAmountControllers.values.forEach((controller) => controller.dispose());
    
    super.dispose();
  }
}






// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/helpers/colors_res.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/select_attendantdialog.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/widgets/payform_invoice.dart';
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
//               .map((customer) => customer['attributes']['name'].toString())
//               .toList();
//           if (this.customers.isEmpty) {
//             this.customers = ['Walk-in Customer'];
//           }
//         });
//       }
//     } catch (e) {
//       debugPrint('Error loading customers: $e');
//       if (mounted) {
//         setState(() {
//           customers = ['Walk-in Customer'];
//         });
//       }
//     }
//   }

//   void _loadTables() async {
//     try {
//       var tables = await widget.systemProvider.getTables();
//       if (mounted) {
//         setState(() {
//           this.tables = tables
//               .map((table) => table['attributes']['name'].toString())
//               .toList();
//         });
//       }
//     } catch (e) {
//       debugPrint('Error loading tables: $e');
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

//   @override
//   Widget build(BuildContext context) {
//     // Disable customer input controls when attendant is verified
//     bool isCustomerInputDisabled = _selectedAttendant != null && _attendantVerified;

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
//                   activeColor: isCustomerInputDisabled ? Colors.grey.shade400 : Colors.grey,
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
//                     decoration: InputDecoration(
//                       labelText: "Enter Customer Name",
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: isCustomerInputDisabled
//                             ? null
//                             : () => customerNameController.clear(),
//                       ),
//                     ),
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
//                 decoration: InputDecoration(
//                   labelText: "Enter Customer Phone number",
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: isCustomerInputDisabled
//                         ? null
//                         : () => customerPhoneController.clear(),
//                   ),
//                 ),
//                 enabled: !isCustomerInputDisabled,
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
//               change >= 0
//                   ? "change: ${Money.format(change)}"
//                   : "Balance Due: ${Money.format(change.abs())}",
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
//             // Validate inputs
//             if (_selectedAttendant == null &&
//                 customerNameController.text.trim().isEmpty &&
//                 selectedCustomer == null) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Please select an attendant or provide a customer name'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//               return;
//             }

//             double receivedAmount = double.tryParse(receivedAmountController.text) ?? 0.0;
//             if (receivedAmount < 0 || (paymentStatus == 'Partial' && (double.tryParse(partialAmountController.text) ?? 0.0) <= 0)) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Invalid amount entered'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//               return;
//             }

//             widget.data = {};
//             Map<String, dynamic> paymentData = {
//               'customerName': customerNameController.text.trim().isNotEmpty
//                   ? customerNameController.text.trim()
//                   : selectedCustomer ?? "Walk-in Customer",
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
//               'attendantId': _selectedAttendant?.apiId?.toString(),
//               'attendantName': _selectedAttendant?.fullName,
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