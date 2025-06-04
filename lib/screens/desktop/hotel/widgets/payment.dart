import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/paymentstate.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool multiplePaymentMethods = false;
  double taxRate = 0;
  double amount = 0;
  String paymentMethod = 'Cash';
  String description = '';
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> paymentHistory = [
    {
      'date': 'May 1, 2025 16:01',
      'subtotal': 50000.00,
      'taxRate': 0.00,
      'taxAmount': 0.00,
      'total': 50000.00,
      'method': 'TRANSFER',
      'type': 'RECEIVED'
    },
    {
      'date': 'May 1, 2025',
      'subtotal': 50000.00,
      'taxRate': 0.00,
      'taxAmount': 0.00,
      'total': 50000.00,
      'method': 'transfer',
      'type': 'PAYMENT'
    }
  ];

  double get totalPaid =>
      paymentHistory.fold(0, (sum, item) => sum + item['total']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Add Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Payment Section
              _buildAddPaymentSection(),

              SizedBox(height: 24),

              // Payment History Section
              _buildPaymentHistorySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddPaymentSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title and switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Payment',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text('Multiple Payment Methods'),
                  Switch(
                    value: multiplePaymentMethods,
                    onChanged: (val) =>
                        setState(() => multiplePaymentMethods = val),
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade300,
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 16),

          // Conditional rendering based on switch
          multiplePaymentMethods
              ? _buildMultiplePaymentsUI(context)
              : _buildSinglePaymentUI(),
        ],
      ),
    );
  }

  Widget _buildSinglePaymentUI() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'Tax Rate (%)',
                onChanged: (val) =>
                    setState(() => taxRate = double.tryParse(val) ?? 0),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'Amount',
                onChanged: (val) =>
                    setState(() => amount = double.tryParse(val) ?? 0),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildDateField(context)),
            SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Payment Method'),
                value: paymentMethod,
                items: ['Cash', 'Card', 'Transfer']
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (val) => setState(() => paymentMethod = val!),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildTextField(
          label: 'Description',
          onChanged: (val) => setState(() => description = val),
        ),
        SizedBox(height: 12),
        Text('Total: ₦${amount.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildMultiplePaymentsUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTaxRateSection(context),
          _buildPaymentMethodsSection(context),
          _buildTotalAmountSection(context),
          _buildAddPaymentButton(context),

          // Additional informational text (optional)
          const SizedBox(height: 20),
          Text(
            'Multiple Payments Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can add multiple payment methods with different amounts.',
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxRateSection(BuildContext context) {
    final paymentState = context.watch<PaymentState>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tax Rate (%)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '0',
              ),
              onChanged: (value) =>
                  paymentState.setTaxRate(double.tryParse(value) ?? 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    final paymentState = context.watch<PaymentState>();

    if (paymentState.paymentMethods.isEmpty) {
      return const SizedBox.shrink(); // Don't show if no methods added
    }

    return Column(
      children: [
        for (int i = 0; i < paymentState.paymentMethods.length; i++)
          _buildPaymentMethodCard(context, i),
      ],
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context, int index) {
    final paymentState = context.read<PaymentState>();
    final method = paymentState.paymentMethods[index];

    return Card(
      margin: EdgeInsets.only(
          top: index == 0 ? 0 : 16), // No top margin for first item
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Method ${index + 1}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => paymentState.removePaymentMethod(index),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: method.method,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select payment method',
              ),
              items: const [
                DropdownMenuItem(value: 'Cash', child: Text('Cash')),
                DropdownMenuItem(
                    value: 'Credit Card', child: Text('Credit Card')),
                DropdownMenuItem(
                    value: 'Bank Transfer', child: Text('Bank Transfer')),
                DropdownMenuItem(
                    value: 'Mobile Payment', child: Text('Mobile Payment')),
              ],
              onChanged: (value) =>
                  paymentState.updatePaymentMethod(index, value, null),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter payment amount',
                prefixText: '\$ ',
              ),
              onChanged: (value) => paymentState.updatePaymentMethod(
                  index, null, double.tryParse(value) ?? 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountSection(BuildContext context) {
    final paymentState = context.watch<PaymentState>();

    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Amount:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildAmountRow('Subtotal:', paymentState.totalAmount),
            _buildAmountRow('Tax (${paymentState.taxRate}%):',
                paymentState.totalWithTax - paymentState.totalAmount),
            const Divider(height: 24),
            _buildAmountRow('Total:', paymentState.totalWithTax, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(String label, double amount, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  bold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: bold
                ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildAddPaymentButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Add Payment Method'),
        onPressed: () => context.read<PaymentState>().addPaymentMethod(),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
    );
  }

  // Widget _buildAmountRow(String label, double amount, {bool bold = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(label, style: bold ? const TextStyle(fontWeight: FontWeight.bold) : null),
  //         Text('\$${amount.toStringAsFixed(2)}',
  //             style: bold ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18) : null),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
          text:
              '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}'),
      decoration: InputDecoration(labelText: 'Payment Date'),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) setState(() => selectedDate = date);
      },
    );
  }

  Widget _buildPaymentHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment History', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('DATE')),
              DataColumn(label: Text('SUBTOTAL')),
              DataColumn(label: Text('TAX RATE')),
              DataColumn(label: Text('TAX AMOUNT')),
              DataColumn(label: Text('TOTAL')),
              DataColumn(label: Text('METHOD')),
              DataColumn(label: Text('TYPE')),
            ],
            rows: paymentHistory
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['date'])),
                      DataCell(Text('₦${item['subtotal'].toStringAsFixed(2)}')),
                      DataCell(Text('${item['taxRate'].toStringAsFixed(2)}%')),
                      DataCell(
                          Text('₦${item['taxAmount'].toStringAsFixed(2)}')),
                      DataCell(Text('₦${item['total'].toStringAsFixed(2)}')),
                      DataCell(Text(item['method'].toString())),
                      DataCell(_buildTypeChip(item['type'])),
                    ]))
                .toList(),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Colors.blue.shade50,
          child: Text('Total Paid: ₦${totalPaid.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildTypeChip(String type) {
    final color = type.toLowerCase() == 'received' ? Colors.green : Colors.blue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text(type.toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
