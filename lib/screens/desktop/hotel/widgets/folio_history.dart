import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/folio_data_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/search_date_filter.dart';

class FolioHistory extends StatefulWidget {
  final Map<String, dynamic>? room;
  final List<dynamic> rooms;
  final Size mediaQuery;
  final Map registerInfo;
  final SystemProvider systemProvider;
  final UserDetails user;
  final VoidCallback onRefreshRooms;

  const FolioHistory({
    super.key,
    required this.room,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
    required this.rooms,
    required this.onRefreshRooms,
  });

  @override
  State<FolioHistory> createState() => _FolioHistoryState();
}

class _FolioHistoryState extends State<FolioHistory> {
  Map<String, dynamic>? lastBooking;
  TextEditingController searchController = TextEditingController();
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    _fetchLastBookingStatus();
  }

  Future<void> _fetchLastBookingStatus() async {
    if (widget.room != null) {
      var booking = await widget.systemProvider
          .getLastBookingRoom(widget.room!['id'].toString());

      if (booking.containsKey('bookingOption')) {
        setState(() {
          lastBooking = booking;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.room?.isNotEmpty == true
        ? "Folio History for ${widget.room?['attributes']?['name'] ?? 'Unknown Room'}"
        : "Folio History";

    return Container(
      width: widget.mediaQuery.width * 0.3,
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
          const SizedBox(height: 5),

          // Search and Date Filter
          SearchWithDateFilter(
            title: 'Search Folio with Booking ID',
            searchController: searchController,
            onChanged: (value) => setState(() {}),
            onClear: () {
              searchController.clear();
              setState(() {});
            },
            onDateRangeSelected: (range) {
              setState(() {
                selectedDateRange = range;
              });
            },
            hintText: 'Search by Booking ID',
            suffixIcon: null,
            backgroundColor: Colors.grey.shade200,
            textStyle: const TextStyle(fontSize: 14, color: Colors.black),
          ),

          const SizedBox(height: 10),

          // List Folio Data by Room ID with Search Functionality
          Expanded(
            child: widget.room == null || widget.room!.isEmpty
                ? const Center(child: Text("No room selected yet!"))
                : Consumer<FolioDataProvider>(
                    builder: (context, folioProvider, child) {
                      final roomId = widget.room?['id'].toString() ?? "";
                      final folios = folioProvider
                          .getFoliosByRoomId(roomId)
                          .where((folio) {
                        final matchesSearch = folio.trackID
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase());

                        final matchesDate = selectedDateRange == null ||
                            (folio.createdAt!
                                    .isAfter(selectedDateRange!.start) &&
                                folio.createdAt!
                                    .isBefore(selectedDateRange!.end));

                        return matchesSearch && matchesDate;
                      }).toList();

                      if (folios.isEmpty) {
                        return const Center(
                            child: Text("No matching folios found!"));
                      }

                      return ListView.builder(
                        itemCount: folios.length,
                        itemBuilder: (context, index) {
                          final folio = folios[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text(
                                folio.customerName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Booking ID: ${folio.trackID}"),
                                  Text(
                                    "Credit: ${Money.format(folio.credit)}",
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                  Text(
                                    "Debit: ${Money.format(folio.debit)}",
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    "Balance: ${Money.format(folio.balance)}",
                                    style:
                                        const TextStyle(color: Colors.orange),
                                  ),
                                  Text("Date: ${folio.createdAt!.toLocal()}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey)),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
