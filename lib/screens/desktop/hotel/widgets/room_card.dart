import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final Map<String, dynamic> room;
  final String name;
  final String price;
  final String type;
  final Map<String, dynamic>? status; // Use dynamic for flexible status
  final Color backgroundColor;
  final String buttonLabel;
  final Function(Map<String, dynamic> room, BuildContext context)? onAction;

  const RoomCard({
    super.key,
    required this.room,
    required this.name,
    required this.price,
    required this.type,
    this.status,
    this.backgroundColor = Colors.blue,
    this.buttonLabel = "Choose Room",
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Name and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    name,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                  Chip(
                    label: Text(
                      price,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black54,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Room Type and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => onAction?.call(room, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
