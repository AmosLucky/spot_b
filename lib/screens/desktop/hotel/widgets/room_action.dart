import 'package:flutter/material.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';

class RoomActionModal extends StatelessWidget {
  final Map<String, dynamic> room;
  final VoidCallback onBookNow;
  final VoidCallback onEditBooking;
  final VoidCallback onTransfer;
  final VoidCallback onMaintenanceReport;
  final VoidCallback onFolioHistory;

  const RoomActionModal(
      {super.key,
      required this.room,
      required this.onBookNow,
      required this.onEditBooking,
      required this.onTransfer,
      required this.onMaintenanceReport,
      required this.onFolioHistory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Room Actions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildActionCard(
            icon: Icons.book_online,
            title: "Book Now",
            color: Colors.green,
            onTap: () {
              Navigator.pop(context);
              print("--------selected room -----------");
              print(room['attributes']['color']);
              // check if room is available
              if (['4', '5', 4, 5].contains(room['attributes']['status']) &&
                  [0, '0'].contains(room['attributes']['is_available'])) {
                Dialogs.alertDialog(
                    context,
                    "Warning",
                    "Room is currently unavailable or under maintenance!",
                    "cancel",
                    "save", []);
                return;
              }

              onBookNow();
            },
          ),
          _buildActionCard(
            icon: Icons.edit,
            title: "Edit Booking",
            color: Colors.blue,
            onTap: () {
              Navigator.pop(context);
              onEditBooking();
            },
          ),
          _buildActionCard(
            icon: Icons.swap_horiz,
            title: "Transfer",
            color: Colors.orange,
            onTap: () {
              Navigator.pop(context);
              onTransfer();
            },
          ),
          _buildActionCard(
            icon: Icons.history,
            title: "Folio History",
            color: Colors.green,
            onTap: () {
              Navigator.pop(context);
              onFolioHistory();
            },
          ),
          _buildActionCard(
            icon: Icons.build,
            title: "Maintenance Report",
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
              onMaintenanceReport();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
