import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../home/hotel_screen_desktop.dart';

class HeaderSection<T> extends StatelessWidget {
  final SystemProvider systemProvider;
  final List<Map<String, dynamic>>
      hotelCategories; // List of categories with label and value
  final List<Map<String, dynamic>> statuses;// List of statuses
  final String? hint;
  final String? statusHint;
  final Size mediaQuery;
  final void Function()? onPressed;
  final UserDetails user;
  final TextEditingController? barcodeCtrl;
  final Function(String)? onClearButtonPressed;
  final Function(String)? onSearchButtonPressed;
  final Function(String)? onKeywordChanged;
  final Function(Map<String, dynamic>?) onCategorySelected;
  final Function(Map<String, dynamic>?) onStatusSelected;

  const HeaderSection({
    super.key,
    required this.systemProvider,
    required this.mediaQuery,
    required this.user,
    this.barcodeCtrl,
    this.hint,
    this.statusHint,
    this.onPressed,
    this.onClearButtonPressed,
    this.onSearchButtonPressed,
    this.onKeywordChanged,
    required this.onCategorySelected,
    required this.onStatusSelected,
    required this.hotelCategories,
    required this.statuses,
  });

  @override
  Widget build(BuildContext context) {
    // List of statuses

    // Selected status
    Map<String, dynamic>? selectedStatus;

    return Container(
      padding: const EdgeInsets.all(2.0),
      width: mediaQuery.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown Button

          const SizedBox(width: 10),
          // Filter by Category Dropdown
          // DropdownButton<String>(
          //   hint: const Text("Filter by Category"),
          //   icon: Icon(Icons.arrow_drop_down, color: primaryColor),
          //   underline: Container(height: 1, color: primaryColor),
          //   items: hotelCategories
          //       .map((category) => DropdownMenuItem<String>(
          //             value: category, // Use the 'value' key for selection
          //             child:
          //                 Text(category['label']!), // Display the 'label' key
          //           ))
          //       .toList(),
          //   onChanged: onCategorySelected,
          // ),
          Expanded(
              child: CustomDropdown<Map<String, dynamic>>(
            items: hotelCategories,
            selectedItem: selectedStatus,
            getItemLabel: (item) => item['attributes']['name'],
            onChanged: (value) => onCategorySelected(value),
            hintText: hint,
            dropdownColor: Colors.white,
          )),
          const SizedBox(width: 10),
          Expanded(
              child: CustomDropdown<Map<String, dynamic>>(
            items: statuses,
            selectedItem: selectedStatus,
            getItemLabel: (item) => item['label'],
            onChanged: (value) => onStatusSelected(value),
            hintText: statusHint,
            dropdownColor: Colors.white,
          )),
          const SizedBox(width: 10),
          SizedBox(width: 1.w,),
      OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: secondaryColor, width: 1), // Outline color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24, // Horizontal padding
            vertical: 16, // Vertical padding
          ),
        ),
        child: Icon(Icons.refresh_outlined, size: 18,)),
          SizedBox(width: 1.w,),
          OutlinedButton(
            onPressed: () async {
              // Check if the register is open before navigating
              _navigateToPage(
                context,
                HotelScreenDesktop(),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: secondaryColor, width: 1), // Outline color and width
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24, // Horizontal padding
                vertical: 16, // Vertical padding
              ),
            ),
            child: Text(
              "DASHBOARD",
              style: TextStyle(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
