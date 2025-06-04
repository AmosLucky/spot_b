import 'package:intl/intl.dart';
import 'package:spotstock_inventory/data/models/schema.dart';

class MaintenanceRoomResponse {
  final MaintenanceRoomData rooms;
  final List<dynamic> roomTypes;
  final MaintenanceStats stats;

  MaintenanceRoomResponse({
    required this.rooms,
    required this.roomTypes,
    required this.stats,
  });

  factory MaintenanceRoomResponse.fromJson(Map<String, dynamic> json) {
    return MaintenanceRoomResponse(
      rooms: MaintenanceRoomData.fromJson(json['rooms']),
      roomTypes: json['room_types'] ?? [],
      stats: MaintenanceStats.fromJson(json['stats']),
    );
  }
}

class MaintenanceRoomData {
  final int currentPage;
  final List<MaintenanceRoom> data;  // Now using the unified MaintenanceRoom
  final PaginationLinks links;

  MaintenanceRoomData({
    required this.currentPage,
    required this.data,
    required this.links,
  });

  factory MaintenanceRoomData.fromJson(Map<String, dynamic> json) {
    return MaintenanceRoomData(
      currentPage: json['current_page'],
      data: (json['data'] as List).map((room) => MaintenanceRoom.fromJson(room)).toList(),
      links: PaginationLinks.fromJson(json),
    );
  }
}

class MaintenanceStats {
  final int totalRooms;
  final int maintenanceRooms;
  final double maintenancePercentage;

  MaintenanceStats({
    required this.totalRooms,
    required this.maintenanceRooms,
    required this.maintenancePercentage,
  });

  factory MaintenanceStats.fromJson(Map<String, dynamic> json) {
    return MaintenanceStats(
      totalRooms: json['total_rooms'],
      maintenanceRooms: json['maintenance_rooms'],
      maintenancePercentage: json['maintenance_percentage']?.toDouble() ?? 0.0,
    );
  }
}

class PaginationLinks {
  final String? firstPageUrl;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? prevPageUrl;

  PaginationLinks({
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) {
    return PaginationLinks(
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}