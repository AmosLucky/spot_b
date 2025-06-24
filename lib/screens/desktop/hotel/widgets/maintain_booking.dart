import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/helper_utils.dart';

import '../../../../common/custom_selector_sheet2.dart';
import '../../../../common/secondary_custom_dropdown.dart';

class MaintainBooking extends StatefulWidget {
  final Map<String, dynamic>? room;
  final Size mediaQuery;
  final Map registerInfo;
  final List rooms;
  final SystemProvider systemProvider;
  final UserDetails user;
  final VoidCallback onRefreshRooms;

  const MaintainBooking({
    super.key,
    required this.room,
    required this.rooms,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
    required this.onRefreshRooms,
  });

  @override
  State<MaintainBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<MaintainBooking> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  String? _urgency = 'Choose Urgency';

  @override
  Widget build(BuildContext context) {
    var title = widget.room?.isNotEmpty == true
        ? "Maintenance Report"
        : "Maintenance Report"; // Default status

    return Container(
      width: widget.mediaQuery.width * 0.3, // Adjust width based on screen size
      constraints: BoxConstraints(
        maxHeight: widget.mediaQuery.height * 0.96,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: widget.room!.isEmpty
                ? const Center(child: Text("No room selected yet!"))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Current Status Container
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Room Name"),
                            Text(widget.room?['attributes']?['name'])
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category"),
                            Text(widget.room?['attributes']?['category']
                                    ?['name'] ??
                                "")
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price"),
                            Text((widget.room?['attributes']['price'])
                                .toString())
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Maintenance Urgency"),
                            Text(widget.room?['maintenance_priority']
                                    ?.toString() ??
                                "N/A")
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Report"),
                            Text((widget.room?['maintenance_report'])
                                    ?.toString() ??
                                "N/A")
                          ],
                        ),

                        SizedBox(
                          height: 4.h,
                        ),

                        // Booking Status Dropdown
                        SecondaryCustomDropDown(
                            color: Colors.grey.withOpacity(0.3),
                            hintText: _urgency,
                            titleText: "Urgency",
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return CustomSelectorBottomSheet2(
                                      height: 40.h,
                                      onSelect: (value, index) {
                                        setState(() {
                                          _urgency = value;
                                        });
                                        debugPrint("valueeee ===>> $_urgency");
                                      },
                                      items: [
                                        "Urgent",
                                        "High",
                                        "Medium",
                                        "Low"
                                      ],
                                    );
                                  });
                            }),
                        const SizedBox(height: 15),

                        // Short Note
                        TextField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            labelText: "Report Reason",
                            hintText: "Add a reason",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors
                                    .grey, // Border color when not focused
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color:
                                    primaryColor, // Border color when focused
                              ),
                            ),
                          ),
                          maxLines: 3,
                        ),

                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 10),

          // Save Changes Button
          CustomButton(
            label: "Report",
            icon: MdiIcons.refresh,
            color: primaryColor,
            onTap: () async {
              // Save changes logic
              final updatedStatus = _urgency;
              final note = _noteController.text;

              // update room values
              Map<List<String>, dynamic> updates = {
                ["attributes", "status"]: 0,
                ["attributes", "color"]:
                    getStatusColor(label: "Under Maintenance"),
                ["is_booked"]: 0,
                ["is_reserved"]: 0,
                ['is_available']: 0,
                ['maintenance_report']: note,
                ['maintenance_priority']: updatedStatus,
              };
              var result = await SystemRepo(online: false, refresh: false)
                  .updateRoomData(widget.rooms, widget.room!['id'].toString(),
                      widget.user, updates);

              if (result != null) {
                // Perform save operation here
                print("===> Updated Status: $updatedStatus");
                print(result);

                // Show confirmation message
                Dialogs.alertDialog(
                  context,
                  "Booking Updated",
                  "Your booking has been successfully updated.",
                  "OK",
                  "",
                  [],
                );

                // Refresh room data
                widget.onRefreshRooms();
              }
            },
          ),
        ],
      ),
    );
  }
}
