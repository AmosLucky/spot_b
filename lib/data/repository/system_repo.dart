import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart'; // Optional if Hive is used for cache store
import 'package:flutter/cupertino.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/helpers/datetime.dart';
import 'package:spotstock_inventory/common/navigation.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/maintenance_model.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/body.dart';
import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../api/api_client.dart';

import 'package:objectbox/objectbox.dart';
import 'package:spotstock_inventory/objectbox.g.dart';

Dio dio = Dio();

class SystemRepo extends ApiClient {
  final dbHelper = DatabaseEngine.instance;

  bool refresh, online;
  SystemRepo({required this.refresh, required this.online});

  // Get user token for authorization
  static Future<String> getToken() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    return user.token;
  }

  // Build cache options dynamically using the endpoint URL as the store path
  CacheOptions buildCacheOptions(String endpoint, {bool forceRefresh = false}) {
    final String cacheStorePath =
        'cache/${endpoint.replaceAll("/", "_")}'; // Replacing slashes to make it a valid directory

    return CacheOptions(
      store: HiveCacheStore(
          cacheStorePath), // Store cache data in a directory based on the endpoint URL
      policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
      maxStale: const Duration(days: 7), // How long the cache remains valid
      hitCacheOnErrorExcept: [
        401,
        403,
        500,
        504
      ], // Cache even on errors except 401 and 403
    );
  }

  // Perform GET request with caching and token authorization
  Future<Response> _fetchData(String endpoint, {bool refresh = false}) async {
    String token = await getToken(); // Get token using the helper method

    print("Fetching: $baseUri$endpoint");

    try {
      var res = await dio.get(
        '$baseUri$endpoint',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      // Print response for debugging
      print(res);

      return res;
    } catch (e) {
      print("Error fetching data: $e");
      rethrow;
    }
  }

  // Perform GET request with caching and token authorization
  Future<Response> _fetchRoomTypes(String endpoint,
      {bool refresh = false}) async {
    String token = await getToken(); // Get token using the helper method

    print("Fetching: $baseUri$endpoint");

    try {
      var res = await dio.get(
        '$baseUri$endpoint',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      // Print response for debugging
      print(res);

      return res;
    } catch (e) {
      print("Error fetching data: $e");
      rethrow;
    }
  }

// Mark room as Dirty
  // Future<Response> markRoomAsDirty({
  //   required int roomId,
  //   required String maintenanceNote,
  //   DateTime? expectedEndDate,
  // }) async {
  //   String token = await getToken();
  //   String endpoint = 'hotel/maintenance/mark-dirty';
  //   try {
  //     final response = await dio.post(
  //       '$baseUri$endpoint', // Verify this endpoint
  //       data: {
  //         'room_id': roomId,
  //         'maintenance_note': maintenanceNote,
  //         'expected_end_date': expectedEndDate?.toIso8601String().split('T')[0],
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         validateStatus: (status) =>
  //             status! < 500, // Don't throw for 4xx errors
  //       ),
  //     );

  //     if (response.statusCode == 404) {
  //       throw Exception('Endpoint not found. Please check the API URL');
  //     }

  //     return response;
  //   } catch (e) {
  //     print("Error marking room as dirty: $e");
  //     rethrow;
  //   }
  // }

  Future<Response> markRoomAsDirty({
    required int roomId,
    required String maintenanceNote,
    DateTime? expectedEndDate,
  }) async {
    String token = await getToken();
    String endpoint = 'hotel/maintenance/mark-dirty';

    try {
      final response = await dio.post(
        '$baseUri$endpoint',
        data: {
          'room_id': roomId,
          'maintenance_note': maintenanceNote,
          'expected_end_date': expectedEndDate?.toIso8601String().split('T')[0],
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      // Handle specific error cases
      if (response.data['success'] == false) {
        throw Exception(
            response.data['message'] ?? 'Failed to mark room as dirty');
      }

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? e.message);
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to mark room as dirty: $e');
    }
  }

// Mark room as Dirty
  Future<Response> setRoomForMaintain({
    required int roomId,
    required String maintenanceNote,
    DateTime? expectedEndDate,
  }) async {
    String token = await getToken();
    String endpoint = 'hotel/maintenance/set';

    try {
      final response = await dio.post(
        '$baseUri$endpoint',
        data: {
          'room_id': roomId,
          'maintenance_note': maintenanceNote,
          'expected_end_date': expectedEndDate?.toIso8601String().split('T')[0],
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      // Handle specific error cases
      if (response.data['success'] == false) {
        throw Exception(
            response.data['message'] ?? 'Failed to mark room for maintenance');
      }

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message'] ?? e.message);
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to mark room as dirty: $e');
    }
  }

  // Fetch Users
  Future<Response> fetchUsersAPI({bool refresh = false}) async {
    return await _fetchData('users-login', refresh: refresh);
  }

  // Fetch customers
  Future<Response> fetchCustomersAPI({bool refresh = false}) async {
    return await _fetchData('customers?page[size]=0', refresh: refresh);
  }

  // Fetch Warehouses
  Future<Response> fetchWarehouseAPI({bool refresh = false}) async {
    print("Fetch warehouse");
    return await _fetchData('pos-warehouses?page[size]=0', refresh: refresh);
  }

  // Fetch Stock Alerts
  Future<Response> fetchStockAlertAPI({bool refresh = false}) async {
    return await _fetchData('product-stock-alerts?page[size]=0',
        refresh: refresh);
  }

  // Fetch Categories getHotelCategories
  Future<Response> fetchCategoriesAPI({bool refresh = false}) async {
    return await _fetchData('product-categories?page[size]=0',
        refresh: refresh);
  }

  // Fetch Hotel Categories
  Future<Response> fetchHotelCategoriesAPI({bool refresh = false}) async {
    return await _fetchData('hotel-categories?page[size]=0', refresh: refresh);
  }

  // Fetch Hotel Amenities
  Future<Response> fetchHotelAmenitiesAPI({bool refresh = false}) async {
    return await _fetchData('hotel-amenities?page[size]=0', refresh: refresh);
  }

  // Fetch Hotel Rooms
  Future<Response> fetchHotelRoomsAPI({bool refresh = false}) async {
    return await _fetchData('hotel-rooms?page[size]=0', refresh: refresh);
    //return await _fetchData('hotel/rooms', refresh: refresh);
  }

  // Fetch Hotel Reservations
  Future<Response> fetchHotelReservationsAPI({bool refresh = false}) async {
    return await _fetchData('hotel-bookings?page[size]=0', refresh: refresh);
  }

  Future<Response> fetchRoomTypes({bool refresh = false}) async {
    return await _fetchData('hotel/room-types', refresh: refresh);
  }

  // Hotel mantenance roomtype
  Future<Response> fetchMaintenanceRoomTypesAPI({bool refresh = false}) async {
    return await _fetchData('hotel/maintenance/rooms', refresh: refresh);
  }

  // Hotel  booking history
  Future<Response> fetchBookingHistory({bool refresh = false}) async {
    return await _fetchData('hotel/bookings/history', refresh: refresh);
  }

  Future<Response> fetchAvailableRooms(
      {bool refresh = false,
      required String roomTypeId,
      required noOfAdult,
      required noOfChildren,
      required startDate,
      required endDate,
      required noOfRooms}) async {
    return await _fetchData(
        'hotel/book-rooms/room-search?room_type_id=${roomTypeId}&adult=${noOfAdult}&children=${noOfChildren}&date=${startDate}-${endDate}&rooms=${noOfRooms}',
        refresh: refresh);
  }

  // Fetch Products
  Future<Response> fetchProductsAPI(
      {bool refresh = false, required int? id}) async {
    var warehouseId = await systemProvider.getWarehouse();
    print("warehouseid.o == ${warehouseId[0]['id']}");
    print("Fetching product now");
    return await _fetchData(
        "products?filter[brand_id]=&filter[product_category_id]=&page[size]=0&warehouse_id=${id ?? warehouseId[0]['id']}",
        refresh: refresh);
  }

  // Future<Response> fetchWarehouseAPI({bool refresh = false}) async {
  //   print("Fetching product now");
  //   return await _fetchData('pos-warehouses?page[size]=0', refresh: refresh);
  // }

  Future<MaintenanceRoomResponse> fetchMaintenanceRooms(
      {bool refresh = false}) async {
    try {
      final response =
          await _fetchData('hotel/maintenance/rooms', refresh: refresh);

      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final responseModel = MaintenanceRoomResponse.fromJson(data);

        // Save to local storage
        await _saveMaintenanceRooms(responseModel.rooms.data);
        print('Maintenance Room ======>>>>>> $response');
        return responseModel;
      }
      throw Exception('Failed to load maintenance rooms');
    } catch (e) {
      // Fallback to local data
      final localRooms = await _getLocalMaintenanceRooms();
      if (localRooms.isNotEmpty) {
        return MaintenanceRoomResponse(
          rooms: MaintenanceRoomData(
            currentPage: 1,
            data: localRooms,
            links: PaginationLinks(),
          ),
          roomTypes: [],
          stats: MaintenanceStats(
            totalRooms: localRooms.length,
            maintenanceRooms:
                localRooms.where((r) => r.status == 'dirty').length,
            maintenancePercentage: 0,
          ),
        );
      }
      rethrow;
    }
  }

  Future<Response> makeRoomAvailable(int roomId) async {
    String token = await getToken();
    String endpoint = 'hotel/maintenance/make-available';

    try {
      final response = await dio.post(
        '$baseUri$endpoint',
        data: {'room_id': roomId},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 404) {
        throw Exception('Endpoint not found. Please check the API URL');
      }

      // Update local storage if API call succeeds
      if (response.statusCode == 200) {
        await _updateLocalRoomStatus(
          roomId: roomId,
          status: 'available',
        );
      }

      return response;
    } catch (e) {
      print("Error making room available: $e");
      rethrow;
    }
  }

  Future<void> _updateLocalRoomStatus({
    required int roomId,
    required String status,
  }) async {
    final store = await DatabaseEngine.instance.getStore();
    final box = store.box<MaintenanceRoom>();
    final room = box.get(roomId);

    if (room != null) {
      room.status = status;
      room.updatedAt = DateTime.now();
      box.put(room);
    }
  }

  Future<void> _saveMaintenanceRooms(List<MaintenanceRoom> rooms) async {
    final store = await DatabaseEngine.instance.getStore();
    final box = store.box<MaintenanceRoom>();
    box.putMany(rooms);
  }

  Future<List<MaintenanceRoom>> _getLocalMaintenanceRooms() async {
    final store = await DatabaseEngine.instance.getStore();
    final box = store.box<MaintenanceRoom>();
    return box.getAll();
  }

  // Fetch Products
  Future<Response> fetchTablesAPI({bool refresh = false}) async {
    return await _fetchData('bar-tables', refresh: refresh);
  }

  Future<Map<String, dynamic>> dashboardStats() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;

    final store = await DatabaseEngine.instance.getStore();

    final orderBox = store.box<Orders>(); // Access the Order box
    final storeBox = store.box<StoreX>(); // Access the StoreItem box
    final bookingBox = store.box<BookingX>(); // Access the StoreItem box

    var todayDate = DateTimeHelper.currentDate(0); // Today's date
    var yesterdayDate = DateTimeHelper.currentDate(1); // Yesterday's date

    // Fetch sales data (sum amounts)
    final salesToday = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(todayDate)))
        .build()
        .property(Orders_.amount)
        .sum();

    final salesYesterday = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(yesterdayDate)))
        .build()
        .property(Orders_.amount)
        .sum();

    final salesWeekly = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfWeek()))
            .and(Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfWeek())))
        .build()
        .property(Orders_.amount)
        .sum();

    final salesLastweek = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastWeek()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastWeek())))
        .build()
        .property(Orders_.amount)
        .sum();

    final salesMonthly = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfMonth()))
            .and(
                Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfMonth())))
        .build()
        .property(Orders_.amount)
        .sum();

    final salesLastmonth = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastMonth()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastMonth())))
        .build()
        .property(Orders_.amount)
        .sum();

    final salesLifetime = await orderBox
        .query(Orders_.billerId.equals(user.id))
        .build()
        .property(Orders_.amount)
        .sum();

    // Fetch order counts (sync/unsync)
    final ordersAllSync = await orderBox
        .query(Orders_.billerId.equals(user.id).and(Orders_.sync.equals(1)))
        .build()
        .count();

    final ordersUnsync = await orderBox
        .query(Orders_.billerId.equals(user.id).and(Orders_.sync.equals(0)))
        .build()
        .count();

    final weeklyAllSync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(1))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfWeek()))
            .and(Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfWeek())))
        .build()
        .count();

    final weeklyUnsync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(0))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfWeek()))
            .and(Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfWeek())))
        .build()
        .count();

    final lastweekAllSync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(1))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastWeek()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastWeek())))
        .build()
        .count();

    final lastweekUnsync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(0))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastWeek()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastWeek())))
        .build()
        .count();

    final monthlyAllSync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(1))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfMonth()))
            .and(
                Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfMonth())))
        .build()
        .count();

    final monthlyUnsync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(0))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfMonth()))
            .and(
                Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfMonth())))
        .build()
        .count();

    final lastmonthAllSync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(1))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastMonth()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastMonth())))
        .build()
        .count();

    final lastmonthUnsync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.sync.equals(0))
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastMonth()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastMonth())))
        .build()
        .count();

    final ordersYesterdaySync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(yesterdayDate))
            .and(Orders_.sync.equals(1)))
        .build()
        .count();

    final ordersYesterdayUnsync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(yesterdayDate))
            .and(Orders_.sync.equals(0)))
        .build()
        .count();

    final ordersTodaySync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(todayDate))
            .and(Orders_.sync.equals(1)))
        .build()
        .count();

    final ordersTodayUnsync = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(todayDate))
            .and(Orders_.sync.equals(0)))
        .build()
        .count();

    // Counts
    final todayCount = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(todayDate)))
        .build()
        .count();

    final yesterdayCount = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.searchDate.equals(yesterdayDate)))
        .build()
        .count();

    final overallCount =
        await orderBox.query(Orders_.billerId.equals(user.id)).build().count();

    final weeklyCount = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfWeek()))
            .and(Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfWeek())))
        .build()
        .count();

    final lastweekCount = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastWeek()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastWeek())))
        .build()
        .count();

    final monthlyCount = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfMonth()))
            .and(
                Orders_.createdAt.lessOrEqualDate(DateTimeHelper.endOfMonth())))
        .build()
        .count();

    final lastmonthCount = await orderBox
        .query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastMonth()))
            .and(Orders_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastMonth())))
        .build()
        .count();

    // get statistics for hotel
    final totalCheckedIn = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.bookingOption.equals('Checked-in')))
        .build()
        .count();

    final totalCheckedOut = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.bookingOption.equals('Checked-out')))
        .build()
        .count();

    final totalReserved = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.bookingOption.equals('Reserved')))
        .build()
        .count();

    final totalAvailable = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.bookingOption.equals('Reserved')))
        .build()
        .count();

    final todayHotelSales = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.searchDate.equals(todayDate)))
        .build()
        .property(BookingX_.amount)
        .sum();

    final yesterdayHotelSales = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.searchDate.equals(yesterdayDate)))
        .build()
        .property(BookingX_.amount)
        .sum();

    final weeklyHotelSales = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfWeek()))
            .and(BookingX_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfWeek())))
        .build()
        .property(BookingX_.amount)
        .sum();

    final lastWeekHotelSales = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfLastWeek()))
            .and(BookingX_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfLastWeek())))
        .build()
        .property(BookingX_.amount)
        .sum();

    final monthlyHotelSales = await bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.createdAt
                .greaterOrEqualDate(DateTimeHelper.startOfMonth()))
            .and(BookingX_.createdAt
                .lessOrEqualDate(DateTimeHelper.endOfMonth())))
        .build()
        .property(BookingX_.amount)
        .sum();

    final lifetimeHotelSales = await bookingBox
        .query(BookingX_.userId.equals(user.id.toString()))
        .build()
        .property(BookingX_.amount)
        .sum();

    // Products, Warehouses, and Categories
    final products = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('products')))
        .build()
        .find();

    final warehouses = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('warehouses')))
        .build()
        .find();

    final categories = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('categories')))
        .build()
        .find();
    print("------------------------------");
    //print(categories[0]);

    final hotel_categories = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_categories')))
        .build()
        .find();
    print("--------------hotel category----------------");
    //print(hotel_categories[0]);

    final hotel_amenities = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_amenities')))
        .build()
        .find();
    print("------------------------------");
    //print(hotel_amenities[0]);

    final hotel_rooms = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_rooms')))
        .build()
        .find();
    print("------------------------------");
    //print(hotel_rooms[0]);

    // final hotel_reservations = await storeBox
    //     .query(StoreX_.billerId
    //         .equals(user.id.toString())
    //         .and(StoreX_.name.equals('hotel_reservations')))
    //     .build()
    //     .find();
    // print("------------------------------");
    // print(hotel_reservations[0]);

    final customers = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('customers')))
        .build()
        .find();
    print("-------------customers-----------------");
    //print(customers[0]);

    final productCount = products.isNotEmpty
        ? systemRecords('products', 'count', products[0].value)
        : 0;
    final warehouseCount = warehouses.isNotEmpty
        ? systemRecords('warehouses', 'count', warehouses[0].value)
        : 0;
    final categoryCount = categories.isNotEmpty
        ? systemRecords('categories', 'count', categories[0].value)
        : 0;
    final hotelCategoryCount = hotel_categories.isNotEmpty
        ? systemRecords('hotel_categories', 'count', hotel_categories[0].value)
        : 0;
    final hotelAmenityCount = hotel_amenities.isNotEmpty
        ? systemRecords('hotel_amenities', 'count', hotel_amenities[0].value)
        : 0;
    final hotelRoomCount = hotel_rooms.isNotEmpty
        ? systemRecords('hotel_rooms', 'count', hotel_rooms[0].value)
        : 0;
    // final hotelReservationCount = hotel_reservations.isNotEmpty
    //     ? systemRecords(
    //         'hotel_reservations', 'count', hotel_reservations[0].value)
    //     : 0;
    final customerCount = customers.isNotEmpty
        ? systemRecords('customers', 'count', customers[0].value)
        : 0;
    final productStockOut = products.isNotEmpty
        ? systemRecords('products', 'instock', products[0].value)
        : 0;
    final productsOutOfStock = products.isNotEmpty
        ? systemRecords('products', 'outstock', products[0].value)
        : 0;

    final totalInventoryQty = products.isNotEmpty
        ? systemRecords('products', 'totalstock', products[0].value)
        : 0;

    final syncedOrders = products.isNotEmpty
        ? systemRecords('synced', 'orders', products[0].value)
        : 0;

    return {
      'salesToday': salesToday,
      'productCount': productCount ?? 0,
      'warehouseCount': warehouseCount ?? 0,
      'categoryCount': categoryCount ?? 0,
      'hotelCategoryCount': hotelCategoryCount ?? 0,
      'hotelAmenityCount': hotelAmenityCount ?? 0,
      'hotelRoomCount': hotelRoomCount ?? 0,
      'totalCheckedIn': totalCheckedIn,
      'totalCheckedOut': totalCheckedOut,
      'totalReserved': totalReserved,
      'todayHotelSales': todayHotelSales,
      'yesterdayHotelSales': yesterdayHotelSales,
      'weeklyHotelSales': weeklyHotelSales,
      'lastweekHotelSales': lastWeekHotelSales,
      'monthlyHotelSales': monthlyHotelSales,
      'lifetimeHotelSales': lifetimeHotelSales,
      // 'hotelReservationCount': hotelReservationCount ?? 0,
      'productsOutOfStock': productsOutOfStock ?? 0,
      'totalInventoryQty': totalInventoryQty ?? 0,
      'customerCount': customerCount ?? 0,
      'productStockOut': productStockOut ?? 0,
      'syncedOrders': syncedOrders ?? 0,
      'todayAmount': salesToday,
      'todayCount': todayCount,
      'todaySync': ordersTodaySync,
      'todayUnsync': ordersTodayUnsync,
      'yesterdayCount': yesterdayCount,
      'overallCount': overallCount,
      'weeklyCount': weeklyCount,
      'lastweekCount': lastweekCount,
      'monthlyCount': monthlyCount,
      'lastmonthCount': lastmonthCount,
      'yesterdayAmount': salesYesterday,
      'yesterdaySync': ordersYesterdaySync,
      'yesterdayUnsync': ordersYesterdayUnsync,
      'overallAmount': salesLifetime,
      'weeklyAmount': salesWeekly,
      'lastweekAmount': salesLastweek,
      'monthlyAmount': salesMonthly,
      'lastmonthAmount': salesLastmonth,
      'overallSync': ordersAllSync,
      'overallUnsync': ordersUnsync,
      'weeklySync': weeklyAllSync,
      'weeklyUnsync': weeklyUnsync,
      'lastweekSync': lastweekAllSync,
      'lastweekUnsync': lastweekUnsync,
      'monthlySync': monthlyAllSync,
      'monthlyUnsync': monthlyUnsync,
      'lastmonthSync': lastmonthAllSync,
      'lastmonthUnsync': lastmonthUnsync
    };
  }

  static systemRecords(type, format, records) {
    var result = 0;
    print(records);
    // return false;
    var json = jsonDecode(records);
    var data = json as List;
    if (type == 'products') {
      if (format == 'count') {
        result = data.length;
      } else if (format == 'instock') {
        num totalProducts = 0; // Use num to handle both int and double
        for (var i in data) {
          print("-------------- stock ------------");
          print(i['attributes']['in_stock']);

          var items = i['attributes']['in_stock'];

          // No need to convert to int, as num can handle both int and double
          if (items > 0) {
            totalProducts += items; // Add to totalProducts regardless of type
          }
        }

        result = totalProducts.toInt();
      } else if (format == 'outstock') {
        var totalProducts = 0;
        for (var i in data) {
          // var items = i['attributes']['in_stock'] as int;
          // var innerData = items['data'] as List;
          if (i['attributes']['in_stock'] == 0) {
            // totalProducts += items;
            totalProducts++;
          }
        }
        result = totalProducts;
      }
    } else if (type == 'warehouses') {
      if (format == 'count') {
        result = data.length;
      }
    } else if (type == 'categories') {
      if (format == 'count') {
        result = data.length;
      }
    } else if (type == 'customers') {
      if (format == 'count') {
        result = data.length;
      }
    } else if (type == 'hotel_categories') {
      if (format == 'count') {
        result = data.length;
      }
    } else if (type == 'hotel_amenities') {
      if (format == 'count') {
        result = data.length;
      }
    } else if (type == 'hotel_rooms') {
      if (format == 'count') {
        result = data.length;
      }
    } else if (format == 'outstock') {
      result = data.length;
    }
    return result;
  }

  // static int systemRecords(String type, String format, String records) {
  //   var result = 0;
  //   try {
  //     var json = jsonDecode(records);

  //     // Handle API response structure - check if the JSON has a 'data' property
  //     var data = json['data'] != null ? json['data'] as List : json as List;

  //     if (type == 'products') {
  //       if (format == 'count') {
  //         result = data.length;
  //       } else if (format == 'instock') {
  //         // Count number of products that have stock > 0
  //         int inStockCount = 0;
  //         for (var i in data) {
  //           var stock = i['attributes']['in_stock'];
  //           if (stock > 0) {
  //             inStockCount++;
  //           }
  //         }
  //         result = inStockCount;
  //       } else if (format == 'outstock') {
  //         // Count products with stock == 0
  //         int outOfStockCount = 0;
  //         for (var i in data) {
  //           if (i['attributes']['in_stock'] == 0) {
  //             outOfStockCount++;
  //           }
  //         }
  //         result = outOfStockCount;
  //       } else if (format == 'totalstock') {
  //         // Sum all in_stock values for total inventory quantity
  //         num totalStock = 0;
  //         for (var i in data) {
  //           var stockAmount = i['attributes']['in_stock'];
  //           if (stockAmount > 0) {
  //             totalStock += stockAmount;
  //           }
  //         }
  //         result = totalStock.toInt();
  //       }
  //     } else if (type == 'warehouses') {
  //       if (format == 'count') {
  //         result = data.length;
  //       }
  //     } else if (type == 'categories') {
  //       if (format == 'count') {
  //         result = data.length;
  //       }
  //     } else if (type == 'customers') {
  //       if (format == 'count') {
  //         result = data.length;
  //       }
  //     } else if (type == 'hotel_categories') {
  //       if (format == 'count') {
  //         result = data.length;
  //       }
  //     } else if (type == 'hotel_amenities') {
  //       if (format == 'count') {
  //         result = data.length;
  //       }
  //     } else if (type == 'hotel_rooms') {
  //       if (format == 'count') {
  //         result = data.length;
  //       }
  //     } else if (type == 'synced') {
  //       // Existing logic for synced orders
  //       // Implementation depends on your app's requirements
  //     }
  //   } catch (e) {
  //     print('Error in systemRecords: $e');
  //   }

  //   return result;
  // }

  Future<List<dynamic>> getCustomers() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final customers = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('customers')))
        .build()
        .findFirst();
    print("=========== customers ============");
    print(customers!.value);
    return jsonDecode(customers.value) ?? [];
  }

  Future<List<dynamic>> getCategories() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final categories = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('categories')))
        .build()
        .findFirst();
    print("=========== categories ============");
    print(categories!.value);
    return jsonDecode(categories.value) ?? [];
  }

  Future<List<dynamic>> getTables() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final tables = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('tables')))
        .build()
        .findFirst();
    print("=========== categories ============");
    print(tables!.value);
    return jsonDecode(tables.value) ?? [];
  }

  Future<List<dynamic>> getHotelCategories() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final hotel_categories = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_categories')))
        .build()
        .findFirst();
    print("=========== hotel categories ============");
    print(hotel_categories!.value);
    return jsonDecode(hotel_categories.value) ?? [];
  }

  Future<List<dynamic>> getHotelAmenities() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final hotel_amenities = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_amenities')))
        .build()
        .findFirst();
    print("=========== hotel amenities ============");
    print(hotel_amenities!.value);
    return jsonDecode(hotel_amenities.value) ?? [];
  }

  Future<List<dynamic>> getHotelRooms() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final hotel_rooms = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_rooms')))
        .build()
        .findFirst();
    print("=========== hotel rooms ============");
    print(hotel_rooms!.value);
    return jsonDecode(hotel_rooms.value) ?? [];
  }

  Future<List<dynamic>> getHotelReservations() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final hotel_reservations = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('hotel_reservations')))
        .build()
        .findFirst();
    print("=========== hotel reservations ============");
    print(hotel_reservations!.value);
    return jsonDecode(hotel_reservations.value) ?? [];
  }

  Future<List<dynamic>> getProducts(int id) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final storeBox = store.box<StoreX>();
    final products = await storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('products')))
        .build()
        .findFirst();
    print("=========== products ============");
    return jsonDecode(products!.value) ?? [];
  }

  Future<List<dynamic>> getWarehouses() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final warehouseBox = store.box<StoreX>();
    final warehouses = await warehouseBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals('warehouses')))
        .build()
        .findFirst();
    print("=========== warehouses ============");
    return jsonDecode(warehouses!.value) ?? [];
  }

  Future<Map<String, dynamic>> getPrinters() async {
    try {
      final user = _getCurrentUser();
      if (user == null) {
        throw Exception("User not found");
      }

      final store = await DatabaseEngine.instance.getStore();
      final storeBox = store.box<StoreX>();

      final printers = await storeBox
          .query(StoreX_.billerId
              .equals(user.id.toString())
              .and(StoreX_.name.equals('printers')))
          .build()
          .findFirst();

      if (printers == null) {
        throw Exception("No printers found for user ID: ${user.id}");
      }

      return printers.toMap();
    } catch (e) {
      print("Error fetching printers: $e");
      return {}; // Return an empty map on failure
    }
  }

  Future<dynamic> updateRoomData(List<dynamic> rooms, String roomId,
      UserDetails user, Map<List<String>, dynamic> updates) async {
    // Debugging: Check room IDs in the list
    print("Room IDs in list: ${rooms.map((r) => r['id']).toList()}");
    print("Searching for Room ID: $roomId");

    int index = rooms.indexWhere((room) => room['id'].toString() == roomId);

    if (index == -1) {
      print('Room with ID "$roomId" not found.');
      return rooms;
    }

    Map<String, dynamic> room = rooms[index];

    updates.forEach((keyPath, newValue) {
      Map<String, dynamic> currentMap = room;

      for (int i = 0; i < keyPath.length - 1; i++) {
        if (currentMap[keyPath[i]] is! Map<String, dynamic>) {
          // If the key doesn't exist or is not a Map, create a new Map
          currentMap[keyPath[i]] = <String, dynamic>{};
        }
        currentMap = currentMap[keyPath[i]];
      }

      // Update or insert the final key
      currentMap[keyPath.last] = newValue;
    });

    // Final updated list
    var outputData = List<dynamic>.from(rooms);

    // Update the database
    await upsertHotelRooms(categoryData: outputData, user: user);

    return room; // Return updated room
  }

  Future<void> upsertHotelRooms({
    required List<dynamic> categoryData,
    required UserDetails user, // Replace with actual user model
  }) async {
    // Prepare the StoreX object
    StoreX hotelRooms = StoreX(
      name: "hotel_rooms",
      value: jsonEncode(categoryData), // Encode the categoryData into JSON
      billerId: user.id.toString(),
      companyId: user.company!.id.toString(),
      lastUpdated: DateTime.now().toIso8601String(),
    );

    // Get ObjectBox store instance
    final store = await DatabaseEngine.instance.getStore();
    final categoryBox = store.box<StoreX>();

    // Check if the record exists
    final existingCategory = categoryBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals("hotel_rooms")))
        .build()
        .findFirst();

    if (existingCategory != null) {
      // If exists, update
      hotelRooms.id = existingCategory.id; // Retain the same ID
      categoryBox.put(hotelRooms);
      print('Hotel Room record updated.');
    } else {
      // If not exists, insert new
      categoryBox.put(hotelRooms);
      print('New Hotel Room record inserted.');
    }
  }

  // Hotel maintenance
  Future<void> upsertMaintenanceRooms(List<dynamic> roomsData) async {
    final store = await DatabaseEngine.instance.getStore();
    final box = store.box<MaintenanceRoom>();

    final rooms =
        roomsData.map((json) => MaintenanceRoom.fromJson(json)).toList();
    box.putMany(rooms);
  }

  Future<List<MaintenanceRoom>> getLocalMaintenanceRooms() async {
    final store = await DatabaseEngine.instance.getStore();
    final box = store.box<MaintenanceRoom>();
    return box.getAll();
  }

  UserDetails? _getCurrentUser() {
    try {
      return Provider.of<UserProvider>(Navigation.getContext(), listen: false)
          .user;
    } catch (e) {
      print("Error retrieving user: $e");
      return null;
    }
  }

  // Future<Map<String, dynamic>> getPrinters() async {
  //   UserDetails user =
  //       Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
  //   final store = await DatabaseEngine.instance.getStore();

  //   final storeBox = store.box<StoreX>();

  //   final printers = await storeBox
  //       .query(StoreX_.billerId
  //           .equals(user.id.toString())
  //           .and(StoreX_.name.equals('printers')))
  //       .build()
  //       .findFirst();
  //   print("=========== printers ============");
  //   // print(products!.value);

  //   return printers!.toMap();
  // }

  Future<List<dynamic>> getInvoices(int registerId) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final invoiceBox = store.box<Invoice>();
    final invoices = invoiceBox
        .query(Invoice_.userId
            .equals(user.id.toString())
            .and(Invoice_.companyId.equals(registerId.toString())))
        .build()
        .find();
    print("=========== invoices list ============");
    print(invoices.length);
    // Convert List<Invoice> to List<dynamic>
    List<dynamic> dynamicInvoices =
        invoices.map((invoice) => invoice.toMap()).toList();
    return dynamicInvoices;
  }

  Future<bool> deleteInvoice(int id) async {
    final store = await DatabaseEngine.instance.getStore();

    final invoiceBox = store.box<Invoice>();
    final deletedCount = invoiceBox.remove(id);
    return deletedCount;
  }

  Future<bool> clearInvoices() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final invoiceBox = store.box<Invoice>();
    final invoices = invoiceBox
        .query(Invoice_.userId.equals(user.id.toString()))
        .build()
        .find();
    invoiceBox.removeMany(invoices.map((invoice) => invoice.id).toList());
    return true;
  }

  Future<List<dynamic>> getTransactions() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final orderBox = store.box<Orders>();
    final transactions =
        orderBox.query(Orders_.billerId.equals(user.id)).build().find();
    print("=========== transactions list ============");
    print(transactions.length);
    return transactions;
  }

  Future<List<Orders>> getTransactionsByDate(
      {DateTime? startDate, DateTime? endDate, int? sync}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();

    // Prepare the base query for the user's transactions and include the date conditions using `and`
    var queryBuilder = sync != null
        ? orderBox.query(
            Orders_.billerId.equals(user.id).and(Orders_.sync.equals(sync)))
        : orderBox.query(Orders_.billerId.equals(user.id));

    if (startDate != null && endDate != null) {
      // Apply both start and end date range
      queryBuilder = sync != null
          ? orderBox.query(Orders_.billerId
              .equals(user.id)
              .and(Orders_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch))
              .and(Orders_.sync.equals(sync)))
          : orderBox.query(Orders_.billerId.equals(user.id).and(
              Orders_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch)));
    } else if (startDate != null) {
      // Apply a single date (specific day till the end of the day)

      // DateTime endOfDay =
      //     DateTime(startDate.year, startDate.month, startDate.day, 23, 59, 59);
      queryBuilder = sync != null
          ? orderBox.query(Orders_.billerId.equals(user.id).and(Orders_
              .searchDate
              .equals(searchDate(startDate))
              .and(Orders_.sync.equals(sync))))
          : orderBox.query(Orders_.billerId
              .equals(user.id)
              .and(Orders_.searchDate.equals(searchDate(startDate))));
    }

    // Order by 'createdAt' in descending order
    queryBuilder =
        queryBuilder.order(Orders_.createdAt, flags: Order.descending);

    // Build and execute the query
    final query = queryBuilder.build();
    final transactions = query.find();

    print("=========== transactions list ============");
    print(transactions.length);

    return transactions;
  }

  Future<List<Orders>> getTransactionsByRegister(
      {DateTime? startDate, DateTime? endDate, String? registerId}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();

    // Prepare the base query for the user's transactions and include the date conditions using `and`
    var queryBuilder = registerId != null
        ? orderBox.query(Orders_.billerId
            .equals(user.id)
            .and(Orders_.register.equals(registerId)))
        : orderBox.query(Orders_.billerId.equals(user.id));

    if (startDate != null && endDate != null) {
      // Apply both start and end date range
      queryBuilder = registerId != null
          ? orderBox.query(Orders_.billerId
              .equals(user.id)
              .and(Orders_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch))
              .and(Orders_.register.equals(registerId)))
          : orderBox.query(Orders_.billerId.equals(user.id).and(
              Orders_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch)));
    } else if (startDate != null) {
      // Apply a single date (specific day till the end of the day)

      // DateTime endOfDay =
      //     DateTime(startDate.year, startDate.month, startDate.day, 23, 59, 59);
      queryBuilder = registerId != null
          ? orderBox.query(Orders_.billerId.equals(user.id).and(Orders_
              .searchDate
              .equals(searchDate(startDate))
              .and(Orders_.register.equals(registerId))))
          : orderBox.query(Orders_.billerId
              .equals(user.id)
              .and(Orders_.searchDate.equals(searchDate(startDate))));
    }

    // Order by 'createdAt' in descending order
    queryBuilder =
        queryBuilder.order(Orders_.createdAt, flags: Order.descending);

    // Build and execute the query
    final query = queryBuilder.build();
    final transactions = query.find();

    print("=========== transactions list ============");
    print(transactions.length);

    return transactions;
  }

  Future<List<BookingX>> getBookingsByRegister(
      {DateTime? startDate, DateTime? endDate, String? registerId}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final bookingBox = store.box<BookingX>();

    // Prepare the base query for the user's transactions and include the date conditions using `and`
    var queryBuilder = registerId != null
        ? bookingBox.query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.folioId.equals(int.tryParse(registerId)!)))
        : bookingBox.query(BookingX_.userId.equals(user.id.toString()));

    if (startDate != null && endDate != null) {
      // Apply both start and end date range
      queryBuilder = registerId != null
          ? bookingBox.query(BookingX_.userId
              .equals(user.id.toString())
              .and(BookingX_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch))
              .and(BookingX_.folioId.equals(int.tryParse(registerId)!)))
          : bookingBox.query(BookingX_.userId.equals(user.id.toString()).and(
              BookingX_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch)));
    } else if (startDate != null) {
      // Apply a single date (specific day till the end of the day)

      // DateTime endOfDay =
      //     DateTime(startDate.year, startDate.month, startDate.day, 23, 59, 59);
      queryBuilder = registerId != null
          ? bookingBox.query(BookingX_.userId.equals(user.id.toString()).and(
              BookingX_.searchDate
                  .equals(searchDate(startDate))
                  .and(BookingX_.folioId.equals(int.tryParse(registerId)!))))
          : bookingBox.query(BookingX_.userId
              .equals(user.id.toString())
              .and(BookingX_.searchDate.equals(searchDate(startDate))));
    }

    // Order by 'createdAt' in descending order
    queryBuilder =
        queryBuilder.order(BookingX_.createdAt, flags: Order.descending);

    // Build and execute the query
    final query = queryBuilder.build();
    final transactions = query.find();

    print("=========== bookings list ============");
    print(transactions.length);

    return transactions;
  }

  Future<List<BookingX>> getHotelTransactionsByRegister(
      {DateTime? startDate, DateTime? endDate, String? registerId}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<BookingX>();

    // Prepare the base query for the user's transactions and include the date conditions using `and`
    var queryBuilder = registerId != null
        ? orderBox.query(BookingX_.id
            .equals(user.id)
            .and(BookingX_.customerId.equals(registerId)))
        : orderBox.query(BookingX_.id.equals(user.id));

    if (startDate != null && endDate != null) {
      // Apply both start and end date range
      queryBuilder = registerId != null
          ? orderBox.query(BookingX_.id
              .equals(user.id)
              .and(BookingX_.createdAt.between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch))
              .and(BookingX_.customerId.equals(registerId)))
          : orderBox.query(BookingX_.id.equals(user.id).and(BookingX_.createdAt
              .between(startDate.millisecondsSinceEpoch,
                  endDate.millisecondsSinceEpoch)));
    } else if (startDate != null) {
      // Apply a single date (specific day till the end of the day)

      // DateTime endOfDay =
      //     DateTime(startDate.year, startDate.month, startDate.day, 23, 59, 59);
      queryBuilder = registerId != null
          ? orderBox.query(BookingX_.id.equals(user.id).and(BookingX_.id
              .equals(searchDate(startDate))
              .and(BookingX_.customerId.equals(registerId))))
          : orderBox.query(BookingX_.id
              .equals(user.id)
              .and(BookingX_.id.equals(searchDate(startDate))));
    }

    // Order by 'createdAt' in descending order
    queryBuilder =
        queryBuilder.order(BookingX_.createdAt, flags: Order.descending);

    // Build and execute the query
    final query = queryBuilder.build();
    final transactions = query.find();

    print("=========== transactions list ============");
    print(transactions.length);

    return transactions;
  }

  Future<List<Register>> getAllRegisters({required String app}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final registerBox = store.box<Register>();

    // Prepare the base query for the user's transactions and include the date conditions using `and`
    var queryBuilder = registerBox.query(Register_.userId
        .equals(user.id.toString())
        .and(Register_.module.equals(app)));

    // Order by 'createdAt' in descending order
    queryBuilder = queryBuilder.order(Register_.id, flags: Order.descending);
    // Build and execute the query
    final query = queryBuilder.build();
    final registers = query.find();

    print("=========== register2 list ============");
    log((registers.map((i) => i.toMap()).toList()).toString());

    return registers;
  }

  Future<List<Register>> getAllRegisterByDate(
      {DateTime? startDate, DateTime? endDate, required String app}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final registerBox = store.box<Register>();

    // Prepare the base query for the user's transactions and include the date conditions using `and`
    var queryBuilder = registerBox.query(Register_.userId
        .equals(user.id.toString())
        .and(Register_.module.equals(app)));

    if (startDate != null && endDate != null) {
      // Apply both start and end date range
      queryBuilder = registerBox.query(Register_.userId
          .equals(user.id.toString())
          .and(
              Register_.lastUpdated.greaterOrEqual(startDate.toIso8601String()))
          .and(Register_.lastUpdated.lessOrEqual(endDate.toIso8601String())));
    } else if (startDate != null) {
      // Apply a single date (specific day till the end of the day)

      // DateTime endOfDay =
      //     DateTime(startDate.year, startDate.month, startDate.day, 23, 59, 59);
      queryBuilder = registerBox.query(Register_.userId
          .equals(user.id.toString())
          .and(Register_.lastUpdated.lessOrEqual(startDate.toIso8601String())));
    }

    // Build and execute the query
    final query = queryBuilder.build();
    final registers = query.find();

    print("=========== register3 list ============");
    log((registers.map((i) => i.toMap()).toList()).toString());
    print(registers.length);

    return registers;
  }

  Future<List<dynamic>> getUnSyncTransactions() async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final orderBox = store.box<Orders>();
    final unsyncedTransactions = orderBox
        .query(Orders_.billerId.equals(user.id).and(Orders_.sync.equals(0)))
        .build()
        .find();
    print("=========== unsync transactions list ============");
    print(unsyncedTransactions.length);
    return unsyncedTransactions;
  }

  Future<Map<String, dynamic>> syncAllTransactions(
    UserDetails user,
  ) async {
    final store = await DatabaseEngine.instance.getStore();

    final orderBox = store.box<Orders>();
    List<Orders> unsyncedOrders = orderBox
        .query(Orders_.billerId.equals(user.id).and(Orders_.sync.equals(0)))
        .build()
        .find();

    print("Syncing started");
    print("Unsyc order length ${unsyncedOrders.length}");
    List data = unsyncedOrders.map((d) {
      print(d.items);
      var aa = jsonDecode(d.items);
      //print("Warehouse ==>> ${aa[0]['product']['stock']['warehouse_id']}");
      return {
        "company": {
          "id": user.id,
          "first_name": user.firstName,
          "last_name": user.lastName,
          "dob": '',
          "salary_date": ''
        },
        "customer_id": null,
        "date": d.createdAt.toIso8601String(),
        "discount": 0,
        "grand_total": d.amount.toString(),
        "hold_ref_no": "",
        "note": "",
        "payment_status": d.status,
        "payment_type": d.paymentMethod,
        "received_amount": int.parse(d.amount.toString().replaceAll('.0', '')),
        "sale_items": jsonDecode(d.items)
            .map((e) => ({
                  "product_id": e['product']['stock']['product_id'],
                  "quantity": e['quantity'],
                  "product_price": e['totalAmount'].toString(),
                  "discount_type": 1,
                  "discount_value": 0,
                  "tax_value": 0,
                  "tax_type": 1
                }))
            .toList(),
        "shipping": 0,
        "status": d.status,
        "tax_rate": 0,
        "warehouse_id": aa[0]['product']['stock']['warehouse_id'],
        "is_offline": 1, //0 for NO, 1 for YES
        "offline_customer_name": d.customerName
      };
    }).toList();

    print("dataaaaaaaaa ==>> $data");

    //print("Order items ==>> ${order.items}");
    try {
      var response = await http.post(Uri.parse('${baseUrl}bulk-sync-sales'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${user.token}"
          },
          body: jsonEncode(data));

      print("Syncing....>>>>>>>>>>>>>>>>>>>");
      log("response body ==> ${response.body}");
      log("response ==> ${response.statusCode}");
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(
            '=========================================================================================');
        print(
            "dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa........>>>>>>>>>>> ==> ${unsyncedOrders}");
        for (var itemData in unsyncedOrders) {
          print("sync data......... .....>>>>>>> ==> $itemData");
          itemData.sync = 1;
          orderBox.put(itemData); // Update the order
        }
        // var syncValue = unsyncedOrders.map((d) => ({
        //   if(jsonDecode(d.items) != []) {
        //     print("sync data ==> $d");
        //     d.sync = 1;
        //     orderBox.put(d);// Update the order
        //   }
        // }));
        return {'status': true, 'message': jsonData['message']};
      } else {
        return {'status': false, 'message': jsonData['message']};
      }
    } catch (e) {
      debugPrint("Sync error$e");
      return {
        'status': false,
        'message': 'Internet connection error!',
      };
    }

    return {};
  }

  Future<Map<String, dynamic>> getReceiptTxn(String txnID) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final orderBox = store.box<Orders>();
    final orders = orderBox
        .query(
            Orders_.billerId.equals(user.id).and(Orders_.trxId.equals(txnID)))
        .build()
        .find();
    var data = orders.isNotEmpty ? orders[0].toMap() : null;
    print("=========== receipt transaction ============");
    print(data);
    return data ?? {};
  }

  Future<Map<String, dynamic>> getHotelReceiptTxn(String txnID) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final bookingBox = store.box<BookingX>();
    final booking = bookingBox
        .query(BookingX_.uid
            .equals(user.id.toString())
            .and(BookingX_.trx.equals(txnID)))
        .build()
        .find();
    var data = booking.isNotEmpty ? booking[0].toMap() : null;
    print("=========== receipt transaction ============");
    print(data);
    return data ?? {};
  }

  Future<Map<String, dynamic>> getLastBookingRoom(String roomID) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final bookingBox = store.box<BookingX>();
    final booking = bookingBox
        .query(BookingX_.uid
            .equals(user.id.toString())
            .and(BookingX_.roomId.equals(roomID)))
        .order(BookingX_.createdAt, flags: Order.descending)
        .build()
        .find();
    var data = booking.isNotEmpty ? booking[0].toMap() : null;
    print("=========== booking transaction ============");
    print(data);
    return data ?? {};
  }

  Future<Map<String, dynamic>> openRegister(
      {required String module, required String amount}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final registerBox = store.box<Register>();
    // Map<String, dynamic> row = {
    //   'opening': amount,
    //   'closing': 0,
    //   DatabaseEngine.scolumnDate: DateTime.now().toString(),
    //   'user_id': user.id,
    //   DatabaseEngine.columnCompany: user.company!.id,
    // };

    final existingRegisters = registerBox
        .query(Register_.userId
            .equals(user.id.toString())
            .and(Register_.module.equals(module))
            .and(Register_.closing.equals('')))
        .build()
        .findFirst();
    if (existingRegisters == null) {
      // Create a new register if none exists
      registerBox.put(Register(
          opening: amount.toString(),
          closing: '',
          userId: user.id.toString(),
          companyId: user.company!.id.toString(),
          lastUpdated: DateTime.now().toString(),
          module: module));
    }
    return {
      'status': true,
      'instance': {'opening': amount}
    };
  }

  Future<Map<String, dynamic>> closeRegister(app, amount) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final registerBox = store.box<Register>();

    // Query for an existing open register for the user (closing is still empty)
    final existingRegister = registerBox
        .query(Register_.userId
            .equals(user.id.toString())
            .and(Register_.module.equals(app))
            .and(Register_.closing.equals('')))
        .build()
        .findFirst();

    if (existingRegister != null) {
      // Update the closing amount and lastUpdated timestamp
      existingRegister.closing = amount.toString();

      // Save the updated register
      registerBox.put(existingRegister);

      return {
        'status': true,
        'instance': {'closing': amount}
      };
    } else {
      // If no open register found, return failure response
      return {'status': false, 'message': 'No open register found to close.'};
    }
  }

  Future<Map<String, dynamic>> isRegisterOpen(String type) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final registerBox = store.box<Register>();
    final existingRegisters = registerBox
        .query(Register_.userId
            .equals(user.id.toString())
            .and(Register_.module.equals(type))
            .and(Register_.closing.equals('')))
        .build()
        .find();
    return {
      'status': existingRegisters.isNotEmpty,
      'total': existingRegisters.length
    };
  }

  Future<Map<String, dynamic>> getRegisterInfo(
      {String? app = "INVENTORY"}) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final registerBox = store.box<Register>();
    final register = registerBox
        .query(Register_.userId
            .equals(user.id.toString())
            .and(Register_.module.equals(app!))
            .and(Register_.closing.equals('')))
        .build()
        .findFirst();
    var data = register!.opening.isNotEmpty ? register.toMap() : null;
    print("=========== register info ============");
    print(data);
    return data ?? {};
  }

  Future<Map<String, dynamic>> checkout(
      Map<String, dynamic> paymentData, total, data) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final orderBox = store.box<Orders>();
    var txnID = generateRandomString(12);
    Orders newOrder = Orders(
      billerId: user.id,
      customerName: paymentData['customerName'] ?? '',
      trxId: txnID,
      amount: total,
      quantity: 1,
      sync: 0,
      status: 1,
      productId: 0,
      createdAt: DateTime.now(),
      searchDate: searchDate(DateTime.now()),
      paymentMethod: paymentData['paymentType'] ?? 'cash',
      items: data,
      others: jsonEncode(paymentData),
      companyId: user.company!.id.toString(),
      register: paymentData['registerId'].toString(),
    );
    orderBox.put(newOrder, mode: PutMode.insert);
    return {'status': true, 'txnID': txnID};
  }

  Future<Map<String, dynamic>> checkoutBooking(
    Map<String, dynamic> paymentData,
    total,
    data,
    booking,
  ) async {
    final store = await DatabaseEngine.instance.getStore();

    final bookingBox = store.box<BookingX>();
    BookingX newBooking = booking;
    bookingBox.put(newBooking);
    return {
      'status': true,
    };
  }

  Future<Map<String, dynamic>> holdInvoice(
      total, registerId, data, table, customerName, customerPhone) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    var txnID = generateRandomString(12);
    final store = await DatabaseEngine.instance.getStore();

    final invoiceBox = store.box<Invoice>();
    Invoice newInvoice = Invoice(
      userId: user.id.toString(),
      companyId: registerId.toString(),
      amount: total,
      reference: txnID,
      invoice: data,
      status: '1',
      tableId: table ?? '',
      customerName: customerName ?? '',
      customerPhone: customerPhone ?? '',
      lastUpdated: searchDate(DateTime.now()),
    );
    invoiceBox.put(newInvoice);
    return {'status': true, 'reference': txnID};
  }

  Future<Response> fetchStaffsAPI({bool refresh = false}) async {
    return await _fetchData('staffs?page[size]=0', refresh: refresh);
  }

  Future<List<dynamic>> getStaffs() async {
    try {
      UserDetails user =
          Provider.of<UserProvider>(Navigation.getContext(), listen: false)
              .user;

      final store = await DatabaseEngine.instance.getStore();
      final staffBox = store.box<StoreX>();

      final staffRecord = staffBox
          .query(StoreX_.billerId
              .equals(user.id.toString())
              .and(StoreX_.name.equals("staffs")))
          .build()
          .findFirst();

      if (staffRecord != null) {
        final List<dynamic> staffs = jsonDecode(staffRecord.value);
        return staffs;
      } else {
        return [];
      }
    } catch (error) {
      print("Error retrieving staffs: $error");
      return [];
    }
  }
}
