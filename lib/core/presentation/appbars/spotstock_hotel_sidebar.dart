import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/constants/colors/spotstock_colors.dart';
import 'package:spotstock_inventory/features/hotel/home/presentation/view_model/hotel_home_viewmodel.dart';

import '../../constants/strings/spotstock_strings.dart';

class SpotstockHotelSidebar extends StatelessWidget {
  final HotelHomeViewmodel viewModel;

  SpotstockHotelSidebar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return ListView(
            children: [
              const SizedBox(height: 12),

              // HOTEL DROPDOWN
              ListTile(
                leading: Icon(
                  Icons.hotel,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(SpotstockStrings.hotel,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
                trailing: Icon(
                  viewModel.hotelMenuOpen
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onTap: () {
                  viewModel.toggleHotelMenuOpen();
                  print(viewModel.selectedIndex);
                  print(viewModel.hotelMenuOpen);
                },
              ),

              if (viewModel.hotelMenuOpen)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      _menuItem(SpotstockStrings.dashboard,
                          Icons.dashboard_outlined, 0),
                      _menuItem(
                          SpotstockStrings.amenities, Icons.room_service, 1),
                      _menuItem(
                          SpotstockStrings.facilities, Icons.apartment, 2),
                      _menuItem(SpotstockStrings.bedTypes, Icons.bed, 3),
                      _menuItem(
                          SpotstockStrings.roomTypes, Icons.meeting_room, 4),
                      _menuItem(
                          SpotstockStrings.premiumServices, Icons.star, 5),
                      _menuItem(SpotstockStrings.rooms, Icons.king_bed, 6),
                    ],
                  ),
                )
            ],
          );
        });
  }

  Widget _menuItem(String title, IconData icon, int index) {
    final isSelected = viewModel.selectedIndex == index;

    return ListTile(
      leading: Icon(icon,
          color: isSelected ? SpotstockColors.orange : SpotstockColors.white),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? SpotstockColors.orange : SpotstockColors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () => viewModel.selectPage(index),
    );
  }
}
