import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../common/primary_text_field.dart';
import '../../../../widgets/custom_dropdown.dart';

class HeaderSection extends StatefulWidget {
  final SystemProvider systemProvider;
  final Size mediaQuery;
  final UserDetails user;
  final List  items;
  Map<String, dynamic>? selectedBranch;
  final String hint;
  final TextEditingController? barcodeCtrl;
  final void Function()? onClearButtonPressed;
  final Function(String)? onSearchButtonPressed;
  final Function(String?)?  onChanged;
  final TextEditingController? controller;
  final Function()? onPressedScan;
  final Function(Map<String, dynamic>?) onBranchSelected;

  HeaderSection({
    super.key,
    required this.systemProvider,
    required this.mediaQuery,
    required this.user,
    required this.items,
    required this.selectedBranch,
    required this.onBranchSelected,
    required this.hint,
    this.barcodeCtrl,
    this.onChanged,
    this.onClearButtonPressed,
    this.controller,
    this.onSearchButtonPressed,
    this.onPressedScan,
  });

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0), // Optional padding for the header
      width: widget.mediaQuery
          .width, // Use the mediaQuery width to set the container width
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
              child: CustomDropdown(
                items: widget.items,
                selectedItem: widget.selectedBranch,
                getItemLabel: (item) => item['attributes']['name'],
                onChanged: (value) => widget.onBranchSelected(value),
                hintText: widget.items != [] ? widget.hint : "",
                dropdownColor: Colors.white,
              ),),

          const SizedBox(
            width: 10,
          ), //

          Expanded(
            child: PrimaryTextField(
              controller: widget.controller,
              hintText: 'Search product by code or name',
              title: '',
              onChanged: widget.onChanged,
              prefixIcon: Icon(Icons.search),
              suffixIcon: GestureDetector(onTap: widget.onClearButtonPressed, child: Icon(Icons.cancel, color: Colors.deepPurple,),),
            ),
          ),
          const SizedBox(
            width: 10,
          ), // Add some space between the search bar and icon
          IconButton(
            iconSize: 35,
            color: primaryColor, // Use the primary color for the icon
            onPressed: widget.onPressedScan,
            icon: Icon(MdiIcons.barcodeScan),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //print("Company data ===>> ${widget.user.}");
    super.initState();
  }
}
