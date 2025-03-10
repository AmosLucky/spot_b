import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/maintain_booking.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/transfer_booking.dart';

import 'edit_booking.dart';
import 'folio_history.dart';
import 'summary.dart';

class SideContainer extends StatelessWidget {
  final String action;
  final Map<String, dynamic>? room;
  final Size mediaQuery;
  final Map registerInfo;
  final List rooms;
  final SystemProvider systemProvider;
  final UserDetails user;
  final VoidCallback onRefreshRoom;

  const SideContainer({
    super.key,
    this.action = "book_now",
    required this.room,
    required this.rooms,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
    required this.onRefreshRoom,
  });

  @override
  Widget build(BuildContext context) {
    if (action == "book_now") {
      return RoomSummary(
        room: room,
        rooms: rooms,
        mediaQuery: mediaQuery,
        registerInfo: registerInfo,
        systemProvider: systemProvider,
        user: user,
      );
    } else if (action == "edit_booking") {
      return EditBooking(
        room: room,
        rooms: rooms,
        mediaQuery: mediaQuery,
        registerInfo: registerInfo,
        systemProvider: systemProvider,
        user: user,
        onRefreshRooms: onRefreshRoom,
      );
    } else if (action == "transfer_booking") {
      return TransferBooking(
        rooms: rooms,
        room: room,
        mediaQuery: mediaQuery,
        registerInfo: registerInfo,
        systemProvider: systemProvider,
        user: user,
        onRefreshRooms: onRefreshRoom,
      );
    } else if (action == "folio_history") {
      return FolioHistory(
        rooms: rooms,
        room: room,
        mediaQuery: mediaQuery,
        registerInfo: registerInfo,
        systemProvider: systemProvider,
        user: user,
        onRefreshRooms: onRefreshRoom,
      );
    } else if (action == "maintenance_report") {
      return MaintainBooking(
        rooms: rooms,
        room: room,
        mediaQuery: mediaQuery,
        registerInfo: registerInfo,
        systemProvider: systemProvider,
        user: user,
        onRefreshRooms: onRefreshRoom,
      );
    } else {
      return EditBooking(
        room: room,
        rooms: rooms,
        mediaQuery: mediaQuery,
        registerInfo: registerInfo,
        systemProvider: systemProvider,
        user: user,
        onRefreshRooms: onRefreshRoom,
      );
    }
  }
}
