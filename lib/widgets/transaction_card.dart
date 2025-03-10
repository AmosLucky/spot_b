import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/style.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Map<String, dynamic> stats;
  final bool isMobile;

  const TransactionCard({
    Key? key,
    required this.title,
    required this.titleColor,
    required this.stats,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile ? 100.0 : 135.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        child: Padding(
          padding: isMobile
              ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
              : const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStats(
                    title: stats['sales'] ?? '0',
                    desc: 'Amount',
                  ),
                  _buildStats(
                    title: stats['count'] ?? '0',
                    desc: 'Total',
                  ),
                  _buildStats(
                    title: '${stats['sync'] ?? '0'}/${stats['unsync'] ?? '0'}',
                    desc: 'Sync/Unsynced',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats({title, desc}) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        Text(
          "${title}",
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "${desc}",
          style: TextStyle(
              fontSize: 12, color: grayColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
