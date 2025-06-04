import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            width: 800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: ColorsRes.cardpurple,
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.print_sharp,
                          size: 10,
                          color: Colors.white,
                        ),
                        Gap(10),
                        Text(
                          "Print Invoice",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                // Header and Invoice Info
                Center(
                  child: Column(
                    children: [
                      // Image.asset('assets/logo.png', height: 60), // Replace with your logo
                      SizedBox(height: 8),
                      Text(
                        'GOLD RHINO HOTEL & SUITES',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '3 Pocket Drive, Nkpokiti Layout, Enugu, Nigeria.\n'
                        'Phone: 09155708598  Email: goldrhinohotelsenugu@gmail.com',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text('Invoice #: INV–2874170',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Date: May 8, 2025'),
                      SizedBox(height: 16),
                    ],
                  ),
                ),

                // Booking and Customer Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoBlock('Booking Details', {
                      'Booking #:': '2874170',
                      'Check-in:': 'May 1, 2025',
                      'Check-out:': 'May 2, 2025',
                      'Status:': 'ACTIVE',
                    }),
                    SizedBox(width: 32),
                    _infoBlock('Customer Details', {
                      'Name:': 'TONIA ADA',
                      'Email:': 'aguyoj18@gmail.com',
                      'Phone:': '0803675434342',
                      'Address:': 'ENUGU',
                    }),
                  ],
                ),
                SizedBox(height: 20),

                // Rooms
                Text('Rooms', style: TextStyle(fontWeight: FontWeight.bold)),
                _buildTable(
                  headers: ['ROOM NUMBER', 'TYPE', 'CHECK-IN', 'CHECK-OUT'],
                  rows: [
                    ['302', 'EXECUTIVE', 'May 1, 2025', 'May 2, 2025']
                  ],
                ),
                SizedBox(height: 20),

                // Premium Services
                Text('Premium Services',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                _buildTable(
                  headers: [
                    'SERVICE',
                    'DATE',
                    'QUANTITY',
                    'UNIT PRICE',
                    'TOTAL'
                  ],
                  rows: [
                    ['Laundry', 'May 1, 2025', '1', '₦15000.00', '₦15000.00']
                  ],
                ),
                SizedBox(height: 20),

                // Payments
                Text('Payments', style: TextStyle(fontWeight: FontWeight.bold)),
                _buildTable(
                  headers: ['DATE', 'METHOD', 'DESCRIPTION', 'AMOUNT'],
                  rows: [
                    ['May 1, 2025', 'TRANSFER', '', '₦50000.00'],
                    ['May 1, 2025', 'TRANSFER', 'PAYMENT MADE', '₦50000.00'],
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Total Paid: ₦100000.00',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 20),

                // Financial Summary
                Text('Financial Summary',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                _buildFinancialSummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoBlock(String title, Map<String, String> data) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...data.entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('${e.key} ${e.value}'),
              )),
        ],
      ),
    );
  }

  Widget _buildTable(
      {required List<String> headers, required List<List<String>> rows}) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          children: headers
              .map((h) => Padding(
                    padding: const EdgeInsets.all(8),
                    child:
                        Text(h, style: TextStyle(fontWeight: FontWeight.bold)),
                  ))
              .toList(),
        ),
        ...rows.map((row) => TableRow(
              children: row
                  .map((cell) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(cell),
                      ))
                  .toList(),
            )),
      ],
    );
  }

  Widget _buildFinancialSummary() {
    final entries = {
      'Booking Fare:': '₦64500.00',
      'Premium Services:': '₦15000.00',
      'Tax Charges:': '₦0.00',
      'Total Cost:': '₦79500.00',
      'Amount Paid:': '₦100000.00',
    };

    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        ...entries.entries.map((e) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(e.key,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(e.value, textAlign: TextAlign.right),
                ),
              ],
            )),
        TableRow(
          decoration: BoxDecoration(color: Colors.green.shade100),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Refund Customer:',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green.shade900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '₦20500.00',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green.shade900),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
