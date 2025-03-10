import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String outOfStock;
  final Color iconColor;
  final IconData icon;
  final double cardHeight;
  final double cardWidth;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.outOfStock,
    required this.iconColor,
    this.cardHeight = 200,
    this.cardWidth = 0.42,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        height: cardHeight,
        width: MediaQuery.of(context).size.width * cardWidth,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                SizedBox(
                  height: 38,
                  width: 38,
                  child: Material(
                    elevation: 10,
                    shadowColor: Colors.black45,
                    borderRadius: BorderRadius.circular(30.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: iconColor,
                      child: IconButton(
                        icon: Icon(icon, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  outOfStock,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
