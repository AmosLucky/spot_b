import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/features/hotel/book_room/presentation/providers/booking_provider.dart';
import '../../../domain/repositories/enums/guest_type.dart';
import '../../../domain/repositories/enums/payment_method.dart';
import '../../state/booking_state.dart';



class BookingConfirmationDialog extends ConsumerStatefulWidget {
  final BookingState bookingState;

  const BookingConfirmationDialog({
    super.key,
    required this.bookingState,
  });

  @override
  ConsumerState<BookingConfirmationDialog> createState() =>
      _BookingConfirmationDialogState();
}

class _BookingConfirmationDialogState
    extends ConsumerState<BookingConfirmationDialog> {
  final _formKey = GlobalKey<FormState>();

  GuestType? _guestType;
  String? _selectedCustomerId;
  String _guestName = '';
  String _phoneNumber = '';
  String _address = '';
  String _email = '';
  double _discount = 0.0;
  double _paidAmount = 0.0;
  PaymentMethod? _paymentMethod;

  // Mock customer list - replace with actual data from your provider
  final List<Map<String, dynamic>> _existingCustomers = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'phone': '+234 801 234 5678'
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'phone': '+234 802 345 6789'
    },
    {
      'id': '3',
      'name': 'Mike Johnson',
      'email': 'mike@example.com',
      'phone': '+234 803 456 7890'
    },
  ];

  double get _totalAfterDiscount {
    return widget.bookingState.totalPrice - _discount;
  }

  double get _balance {
    return _totalAfterDiscount - _paidAmount;
  }

  void _onCustomerSelected(String? customerId) {
    if (customerId == null) return;

    final customer = _existingCustomers.firstWhere(
      (c) => c['id'] == customerId,
      orElse: () => {},
    );

    setState(() {
      _selectedCustomerId = customerId;
      _guestName = customer['name'] ?? '';
      _email = customer['email'] ?? '';
      _phoneNumber = customer['phone'] ?? '';
    });
  }

  void _handleBooking() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_guestType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a guest type'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_paymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _formKey.currentState!.save();
    ref.read(bookingControllerProvider.notifier).createBooking();

    // Return booking data to be processed
    Navigator.of(context).pop({
      'guestType': _guestType,
      'customerId': _selectedCustomerId,
      'guestName': _guestName,
      'phoneNumber': _phoneNumber,
      'address': _address,
      'email': _email,
      'discount': _discount,
      'paidAmount': _paidAmount,
      'paymentMethod': _paymentMethod,
      'totalAfterDiscount': _totalAfterDiscount,
      'balance': _balance,
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00', 'en_US');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Complete Your Booking',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Customer Information Section
                  const Text(
                    'Customer Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Guest Type
                  _buildLabel('Guest Type', required: true),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<GuestType>(
                    value: _guestType,
                    decoration: _inputDecoration('Select guest type'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a guest type';
                      }
                      return null;
                    },
                    items: const [
                      DropdownMenuItem(
                        value: GuestType.walkin,
                        child: Text('Walk-in'),
                      ),
                      DropdownMenuItem(
                        value: GuestType.existing,
                        child: Text('Existing Guest'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _guestType = value;
                        // Reset fields when changing guest type
                        _selectedCustomerId = null;
                        _guestName = '';
                        _email = '';
                        _phoneNumber = '';
                        _address = '';
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Conditional fields based on guest type
                  if (_guestType == GuestType.existing) ...[
                    _buildLabel('Select Customer', required: true),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedCustomerId,
                      decoration: _inputDecoration('Select customer'),
                      validator: (value) {
                        if (_guestType == GuestType.existing && value == null) {
                          return 'Please select a customer';
                        }
                        return null;
                      },
                      items: _existingCustomers
                          .map<DropdownMenuItem<String>>((customer) {
                        return DropdownMenuItem<String>(
                          value: customer['id'] as String,
                          child: Text(customer['name']),
                        );
                      }).toList(),
                      onChanged: _onCustomerSelected,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Guest Name (required for walk-in, read-only for existing)
                  if (_guestType != null) ...[
                    _buildLabel('Guest Name', required: true),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _guestName,
                      enabled: _guestType == GuestType.walkin,
                      decoration: _inputDecoration('Enter guest name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter guest name';
                        }
                        return null;
                      },
                      onChanged: (value) => _guestName = value,
                      onSaved: (value) => _guestName = value ?? '',
                    ),
                    const SizedBox(height: 16),

                    // Phone Number (required for walk-in, read-only for existing)
                    _buildLabel('Phone Number', required: true),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _phoneNumber,
                      enabled: _guestType == GuestType.walkin,
                      decoration: _inputDecoration('Enter phone number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                      onChanged: (value) => _phoneNumber = value,
                      onSaved: (value) => _phoneNumber = value ?? '',
                    ),
                    const SizedBox(height: 16),

                    // Email (read-only for existing, editable for walk-in)
                    _buildLabel('Email',
                        required: _guestType == GuestType.walkin),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: _email,
                      enabled: _guestType == GuestType.walkin,
                      decoration: _inputDecoration('Enter email address'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (_guestType == GuestType.walkin &&
                            (value == null || value.trim().isEmpty)) {
                          return 'Please enter email address';
                        }
                        if (value != null &&
                            value.isNotEmpty &&
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) => _email = value,
                      onSaved: (value) => _email = value ?? '',
                    ),
                    const SizedBox(height: 16),

                    // Address (only for walk-in)
                    if (_guestType == GuestType.walkin) ...[
                      _buildLabel('Address'),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: _address,
                        decoration:
                            _inputDecoration('Enter address (optional)'),
                        maxLines: 2,
                        onChanged: (value) => _address = value,
                        onSaved: (value) => _address = value ?? '',
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],

                  const Divider(height: 32),

                  // Payment Information Section
                  const Text(
                    'Payment Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Discount
                  _buildLabel('Discount'),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: _inputDecoration('Enter discount amount (₦)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final discount = double.tryParse(value);
                        if (discount == null) {
                          return 'Please enter a valid amount';
                        }
                        if (discount > widget.bookingState.totalPrice) {
                          return 'Discount cannot exceed total price';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _discount = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Paid Amount
                  _buildLabel('Paid Amount'),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: _inputDecoration('Enter amount paid (₦)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final paid = double.tryParse(value);
                        if (paid == null) {
                          return 'Please enter a valid amount';
                        }
                        if (paid > _totalAfterDiscount) {
                          return 'Paid amount cannot exceed total';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _paidAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Payment Method
                  _buildLabel('Payment Method', required: true),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<PaymentMethod>(
                    value: _paymentMethod,
                    decoration: _inputDecoration('Select payment method'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a payment method';
                      }
                      return null;
                    },
                    items: const [
                      DropdownMenuItem(
                        value: PaymentMethod.wallet,
                        child: Text('Wallet'),
                      ),
                      DropdownMenuItem(
                        value: PaymentMethod.pos,
                        child: Text('POS'),
                      ),
                      DropdownMenuItem(
                        value: PaymentMethod.transfer,
                        child: Text('Transfer'),
                      ),
                      DropdownMenuItem(
                        value: PaymentMethod.cash,
                        child: Text('Cash'),
                      ),
                      DropdownMenuItem(
                        value: PaymentMethod.compliment,
                        child: Text('Compliment'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value;
                      });
                    },
                  ),

                  const Divider(height: 32),

                  // Booking Summary Section
                  const Text(
                    'Booking Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Check-in:',
                          widget.bookingState.checkInDate != null
                              ? DateFormat('MM/dd/yyyy')
                                  .format(widget.bookingState.checkInDate!)
                              : '-',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'Check-out:',
                          widget.bookingState.checkOutDate != null
                              ? DateFormat('MM/dd/yyyy')
                                  .format(widget.bookingState.checkOutDate!)
                              : '-',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'Nights:',
                          '${widget.bookingState.numberOfNights}',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'Total Rooms:',
                          '${widget.bookingState.numberOfRooms}',
                        ),
                        const Divider(height: 16),
                        const Text(
                          'Selected Rooms:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...widget.bookingState.bookingDays.map((day) {
                          final rooms =
                              widget.bookingState.selectedRooms[day] ?? [];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('MM/dd/yyyy').format(day),
                                  style: const TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '${rooms.length} room(s)',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const Divider(height: 16),
                        _buildSummaryRow(
                          'Subtotal:',
                          '₦${formatter.format(widget.bookingState.totalPrice)}',
                        ),
                        if (_discount > 0) ...[
                          const SizedBox(height: 8),
                          _buildSummaryRow(
                            'Discount:',
                            '- ₦${formatter.format(_discount)}',
                            valueColor: Colors.red,
                          ),
                        ],
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'Total Price:',
                          '₦${formatter.format(_totalAfterDiscount)}',
                          isBold: true,
                        ),
                        if (_paidAmount > 0) ...[
                          const SizedBox(height: 8),
                          _buildSummaryRow(
                            'Paid Amount:',
                            '₦${formatter.format(_paidAmount)}',
                            valueColor: Colors.green,
                          ),
                          const SizedBox(height: 8),
                          _buildSummaryRow(
                            'Balance:',
                            '₦${formatter.format(_balance)}',
                            isBold: true,
                            valueColor:
                                _balance > 0 ? Colors.orange : Colors.green,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _handleBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          'Confirm Booking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool required = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        children: [
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
