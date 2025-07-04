import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/widgets/custom_widgets.dart';

class TableView extends StatefulWidget {
  final Size mediaQuery;
  final Function(Map) onTableSelected;

  const TableView({
    super.key,
    required this.mediaQuery,
    required this.onTableSelected,
  });

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  // Expanded dummy data for tables
  final List<Map<String, dynamic>> _tables = [
    {
      'attendant_name': 'Mike',
      'table_number': 'Table 1',
      'items_sold': 10,
      'image_url': 'https://example.com/table1.jpg',
      'orders': [
        {'name': 'Burger', 'price': 1500.0, 'quantity': 2},
        {'name': 'Fries', 'price': 800.0, 'quantity': 3},
        {'name': 'Soda', 'price': 500.0, 'quantity': 2},
      ]
    },
    {
      'attendant_name': 'Sarah',
      'table_number': 'Table 2',
      'items_sold': 8,
      'image_url': 'https://example.com/table2.jpg',
      'orders': [
        {'name': 'Pizza', 'price': 2500.0, 'quantity': 1},
        {'name': 'Soda', 'price': 500.0, 'quantity': 4},
        {'name': 'Salad', 'price': 1200.0, 'quantity': 1},
      ]
    },
    {
      'attendant_name': 'John',
      'table_number': 'Table 3',
      'items_sold': 12,
      'image_url': 'https://example.com/table3.jpg',
      'orders': [
        {'name': 'Salad', 'price': 1200.0, 'quantity': 2},
        {'name': 'Steak', 'price': 3500.0, 'quantity': 1},
        {'name': 'Juice', 'price': 600.0, 'quantity': 3},
      ]
    },
    {
      'attendant_name': 'Emma',
      'table_number': 'Table 4',
      'items_sold': 15,
      'image_url': 'https://example.com/table4.jpg',
      'orders': [
        {'name': 'Pasta', 'price': 1800.0, 'quantity': 2},
        {'name': 'Wine', 'price': 2500.0, 'quantity': 1},
        {'name': 'Dessert', 'price': 1000.0, 'quantity': 2},
      ]
    },
    {
      'attendant_name': 'Lisa',
      'table_number': 'Table 5',
      'items_sold': 7,
      'image_url': 'https://example.com/table5.jpg',
      'orders': [
        {'name': 'Sushi', 'price': 2200.0, 'quantity': 1},
        {'name': 'Tea', 'price': 400.0, 'quantity': 3},
      ]
    },
    {
      'attendant_name': 'Tom',
      'table_number': 'Table 6',
      'items_sold': 9,
      'image_url': 'https://example.com/table6.jpg',
      'orders': [
        {'name': 'Sandwich', 'price': 900.0, 'quantity': 2},
        {'name': 'Coffee', 'price': 600.0, 'quantity': 3},
        {'name': 'Cake', 'price': 800.0, 'quantity': 1},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: widget.mediaQuery.height - 50,
        child: GridView.builder(
          itemCount: _tables.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Ensure exactly 4 cards per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            var table = _tables[index];
            return InkWell(
              onTap: () {
                widget.onTableSelected(table);
              },
              child: TableCard(table: table),
            );
          },
        ),
      ),
    );
  }
}

class TableCard extends StatefulWidget {
  final Map table;

  const TableCard({
    super.key,
    required this.table,
  });

  @override
  State<TableCard> createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String attendantName = capitalize(widget.table['attendant_name']);
    final String tableNumber = widget.table['table_number'];
    final int itemsSold = widget.table['items_sold'];
    final String imageUrl = widget.table['image_url'] ??
        'https://static.vecteezy.com/system/resources/previews/006/059/989/non_2x/crossed-camera-icon-avoid-taking-photos-image-is-not-available-illustration-free-vector.jpg';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Tooltip(
        message: attendantName,
        showDuration: const Duration(seconds: 3),
        waitDuration: const Duration(milliseconds: 500),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imageUrl),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "Items: $itemsSold",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black.withOpacity(0.6),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      attendantName,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black.withOpacity(0.7),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      tableNumber,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (_isHovered && attendantName.length > 20)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    attendantName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TableSummary extends StatelessWidget {
  final Map selectedTable;
  final Size mediaQuery;

  const TableSummary({
    super.key,
    required this.selectedTable,
    required this.mediaQuery,
  });

  @override
  Widget build(BuildContext context) {
    final orders = selectedTable['orders'] as List;
    final double total = orders.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Container(
      width: 25.w,
      height: mediaQuery.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "${selectedTable['table_number']} - ${selectedTable['attendant_name']}",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text(order['name']),
                  subtitle: Text(
                      'Qty: ${order['quantity']} | Price: ₦${Money.format(order['price'])}'),
                  trailing: Text(
                      '₦${Money.format(order['price'] * order['quantity'])}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₦${Money.format(total)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Bill submitted for ${selectedTable['table_number']}'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: Size(double.infinity, 5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}