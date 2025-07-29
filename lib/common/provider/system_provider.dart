import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
import 'package:spotstock_inventory/common/navigation.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/objectbox.g.dart';

import '../../data/models/hold_model.dart';
import 'response_state.dart';
import 'user_provider.dart';

class SystemProvider with ChangeNotifier {
  // List<NameModel> _items = [];
  SystemProvider() {
    _getDashboardFeed();
    loadOrders();
  }
  final dbHelper = DatabaseEngine.instance;

  // declare response state setter and getter
  ResponseState? _responseState;
  ResponseState? get state => _responseState;

  bool _connectionStatus = false;
  bool get connectionStatus => _connectionStatus;

  bool _dataFetched = false;
  bool get dataFetched => _dataFetched;

  List _roomTypesItems = [];
  List get roomTypesItems => _roomTypesItems;

  List<Orders> _orders = [];
List<Orders> get orders => _orders;

  Map _roomResult = {};
  Map get roomResult => _roomResult;

  int? _warehouseIds;
  int? get warehouseIds => _warehouseIds;

  Map<String, dynamic> _dashboardStats = {};
  Map<String, dynamic> get dashboardStats => _dashboardStats;

  dynamic get refreshData => _refreshData();
  // List<NameModel> get items {
  //   return [..._items];
  // }

    // **NEW: Hold records management**
  List<HoldRecord> _holdRecords = [];
  List<HoldRecord> get holdRecords => _holdRecords;


Future<void> loadOrders() async {
  final store = await DatabaseEngine.instance.getStore();
  final orderBox = store.box<Orders>();
  _orders = orderBox.getAll();
  notifyListeners();
}

void updateOrder(Orders updatedOrder) {
  final index = _orders.indexWhere((o) => o.trxId == updatedOrder.trxId);
  if (index != -1) {
    _orders[index] = updatedOrder;
    notifyListeners();
  } else {
    _orders.add(updatedOrder);
    notifyListeners();
  }
}


  // **NEW: Hold records methods**
  Future<List<HoldRecord>> getHoldRecords() async {
    try {
      // First try to fetch from API if online
      bool isConnected = await InternetUtils.isConnected();
      if (isConnected) {
        await fetchHoldRecords(true, true);
      }
      
      // Get from local storage
      final holds = await SystemRepo(refresh: false, online: false).getLocalHoldRecords();
      _holdRecords = holds;
      notifyListeners();
      return holds;
    } catch (e) {
      print('Error getting hold records: $e');
      return [];
    }
  }

  Future<bool> fetchHoldRecords(bool refresh, bool connectionStatus) async {
    UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();
        
        Response response = await SystemRepo(refresh: refresh, online: connectionStatus).fetchHoldRecordsAPI();
        
        print("============= Hold Records API Response ===============");
        print(response);
        
        if (response.statusCode == 200) {
          final holdData = response.data["data"];
          
          // Store in local database
          StoreX holdRecords = StoreX(
            name: "hold_records",
            value: jsonEncode(holdData),
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );
          
          final store = await DatabaseEngine.instance.getStore();
          final holdBox = store.box<StoreX>();
          
          final existingHolds = holdBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("hold_records")))
              .build()
              .findFirst();
          
          if (existingHolds != null) {
            holdRecords.id = existingHolds.id;
            holdBox.put(holdRecords);
            print('Hold records updated.');
          } else {
            holdBox.put(holdRecords);
            print('New hold records inserted.');
          }
          
          _responseState = ResponseState.done;
          notifyListeners();
          print('Successfully updated hold records.');
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }
      
      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> createHoldRecord(Map<String, dynamic> holdData) async {
    try {
      bool isConnected = await InternetUtils.isConnected();
      if (isConnected) {
        final response = await SystemRepo(refresh: false, online: true).createHoldRecordAPI(holdData);
        if (response['status'] == true) {
          // Refresh local hold records
          await fetchHoldRecords(true, true);
          return true;
        }
      } else {
        // Store locally for later sync
        await SystemRepo(refresh: false, online: false).storeHoldRecordLocally(holdData);
        return true;
      }
      return false;
    } catch (e) {
      print('Error creating hold record: $e');
      return false;
    }
  }

  Future<bool> deleteHoldRecord(int holdId) async {
    try {
      bool isConnected = await InternetUtils.isConnected();
      if (isConnected) {
        final response = await SystemRepo(refresh: false, online: true).deleteHoldRecordAPI(holdId);
        if (response['status'] == true) {
          // Remove from local storage
          await SystemRepo(refresh: false, online: false).deleteLocalHoldRecord(holdId);
          // Refresh hold records list
          await getHoldRecords();
          return true;
        }
      } else {
        // Mark for deletion when online
        await SystemRepo(refresh: false, online: false).markHoldRecordForDeletion(holdId);
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting hold record: $e');
      return false;
    }
  }

  // Add paid invoice to storage
  Future<void> addPaidInvoice(Map<String, dynamic> transactionData) async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final paidInvoiceBox = store.box<PaidInvoice>();
      
      PaidInvoice paidInvoice = PaidInvoice(
        reference: transactionData['trxId'] ?? '',
        customerName: transactionData['customerName'] ?? '',
        attendantName: transactionData['attendantName'],
        amount: transactionData['amount']?.toDouble() ?? 0.0,
        paidAt: DateTime.now().toIso8601String(),
        userId: _getCurrentUser().id.toString(),
        companyId: _getCurrentUser().company?.id.toString() ?? '',
        originalInvoiceData: jsonEncode(transactionData),
      );
      
      paidInvoiceBox.put(paidInvoice);
      print('Paid invoice added successfully: ${paidInvoice.reference}');
    } catch (e) {
      print('Error adding paid invoice: $e');
      throw e;
    }
  }

  // Get paid invoices
  Future<List<dynamic>> getPaidInvoices() async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final paidInvoiceBox = store.box<PaidInvoice>();
      final user = _getCurrentUser();
      
      final paidInvoices = paidInvoiceBox
          .query(PaidInvoice_.userId.equals(user.id.toString()))
          .order(PaidInvoice_.paidAt, flags: Order.descending)
          .build()
          .find();
      
      return paidInvoices.map((invoice) => invoice.toMap()).toList();
    } catch (e) {
      print('Error getting paid invoices: $e');
      return [];
    }
  }

  // Clear paid invoices
  Future<void> clearPaidInvoices() async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final paidInvoiceBox = store.box<PaidInvoice>();
      final user = _getCurrentUser();
      
      final paidInvoices = paidInvoiceBox
          .query(PaidInvoice_.userId.equals(user.id.toString()))
          .build()
          .find();
      
      paidInvoiceBox.removeMany(paidInvoices.map((invoice) => invoice.id).toList());
      print('Paid invoices cleared successfully');
    } catch (e) {
      print('Error clearing paid invoices: $e');
      throw e;
    }
  }


  Future<dynamic> _getDashboardFeed() async {
    _responseState = ResponseState.loading;
    notifyListeners();
    var response =
        await SystemRepo(refresh: false, online: false).dashboardStats();
    _responseState = ResponseState.done;
    print('======== dashboard stats records ============');
    print(response);
    _dashboardStats = response;
    notifyListeners();
  }

  Future<dynamic> _refreshData() async {
    bool isConnected = await InternetUtils.isConnected();
    print("============ current connection state 2 ==============");
    print(isConnected);
    _getDashboardFeed();
    fetchWarehouses(true, isConnected
        // _connectionStatus
        );
    fetchCategories(true, isConnected // _connectionStatus
        );
    fetchHotelCategories(true, isConnected
        // _connectionStatus
        );
    fetchHotelAmenities(true, isConnected
        // _connectionStatus
        );
    fetchHotelRooms(true, isConnected
        // _connectionStatus
        );
    // fetchHotelReservations(true, isConnected
    //     // _connectionStatus
    //     );
    fetchCustomers(true, isConnected
        // _connectionStatus
        );
    fetchStockAlerts(true, isConnected
        //_connectionStatus
        );
    fetchProducts(true, isConnected, null
        // _connectionStatus
        );
    await fetchStaffs(true, isConnected);

    print("Fetching Data");
    fetchTables(true, isConnected);
    _responseState = ResponseState.done;
  }

  Future<dynamic> forcefulRefresh(connectionResult) async {
    print("============ current connection state 3 force ==============");
    print(connectionResult);
    print("fETCHING DATA NOW");
    _responseState = ResponseState.loading;
    _dataFetched = true;
    notifyListeners();

    print(
        ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Datas Syncinggg');
    print(
        ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Datas Syncinggg');
    print(
        ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Datas Syncinggg');
    await _getDashboardFeed();
    await fetchWarehouses(true, connectionResult);
    await fetchCategories(true, connectionResult);
    await fetchHotelCategories(true, connectionResult);
    await fetchHotelAmenities(true, connectionResult);
    await fetchHotelRooms(true, connectionResult);
    await getRoomTypes();
    //fetchHotelReservations(true, connectionResult);
    print("fetcheddd");
    await fetchCustomers(true, connectionResult);
    await fetchProducts(true, connectionResult, null);
    await fetchTables(true, connectionResult);
    await fetchStaffs(true, connectionResult);
    // fetchStockAlerts(true, connectionResult);
    _responseState = ResponseState.done;
    _dataFetched = false;
    
  }

  void checkConnection(bool value) {
    _connectionStatus = value;
    _refreshData();
    notifyListeners();
  }

  // fetch warehouses
  Future<bool> fetchWarehouses(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchWarehouseAPI();
        print("============= system Repo Result Warehouses ===============");
        print(response);

        if (response.statusCode == 200) {
          final warehouseData = response.data["data"];

          _warehouseIds = response.data['data'][0]['id'];
          print("warehouse data ==>> $warehouseData");

          // Convert the warehouse data into a list of StoreX objects
          StoreX warehouses = StoreX(
            name: "warehouses",
            value: jsonEncode(warehouseData),
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final warehouseBox = store.box<StoreX>();

          final existingWarehouse = warehouseBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("warehouses")))
              .build()
              .findFirst(); // Find first matching record

          if (existingWarehouse != null) {
            // Record exists, update it
            warehouses.id =
                existingWarehouse.id; // Ensure it has the same ID for updating
            warehouseBox
                .put(warehouses); // This will update the existing record
            print('Warehouse record updated.');
          } else {
            // No record exists, insert new
            warehouseBox.put(warehouses); // This will insert a new record
            print('New warehouse record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          print('Successfully updated warehouse records.');
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }
      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchStockAlerts(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchStockAlertAPI();
        print("============= system Repo Result Stock ===============");
        print(response);

        if (response.statusCode == 200) {
          final stockAlertData = response.data["data"];

          StoreX stockAlerts = StoreX(
            name: "stock_alert",
            value: jsonEncode(stockAlertData),
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final stockAlertBox = store.box<StoreX>();

          final existingStock = stockAlertBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("stock_alert")))
              .build()
              .findFirst(); // Find first matching record

          if (existingStock != null) {
            // Record exists, update it
            stockAlerts.id =
                existingStock.id; // Ensure it has the same ID for updating
            stockAlertBox
                .put(stockAlerts); // This will update the existing record
            print('Stock alert record updated.');
          } else {
            // No record exists, insert new
            stockAlertBox.put(stockAlerts); // This will insert a new record
            print('New Stock alert record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          print('Successfully updated stock alert records.');
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }
      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchCustomers(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchCustomersAPI();
        print("============= system Repo Result Customers ===============");

        if (response.statusCode == 200) {
          final customerData = response.data["data"];

          StoreX customers = StoreX(
            name: "customers",
            value: jsonEncode(
                customerData), // Encode the entire customerData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final customerBox = store.box<StoreX>();

          // Check if the customer record already exists
          final existingCustomer = customerBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("customers")))
              .build()
              .findFirst(); // Find first matching record

          if (existingCustomer != null) {
            // Record exists, update it
            customers.id =
                existingCustomer.id; // Ensure it has the same ID for updating
            customerBox.put(customers); // This will update the existing record
            print('Customer record updated.');
          } else {
            // No record exists, insert new
            customerBox.put(customers); // This will insert a new record
            print('New customers record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchCategories(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchCategoriesAPI();
        print("============= system Repo Result Category ===============");

        if (response.statusCode == 200) {
          final categoryData = response.data["data"];

          StoreX categories = StoreX(
            name: "categories",
            value: jsonEncode(categoryData),
            // Encode the entire categoryData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final categoryBox = store.box<StoreX>();

          // Check if the category record already exists
          final existingCategory = categoryBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("categories")))
              .build()
              .findFirst(); // Find first matching record

          if (existingCategory != null) {
            // Record exists, update it
            categories.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox.put(categories); // This will update the existing record
            print('Category record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(categories); // This will insert a new record
            print('New category record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchTables(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchTablesAPI();
        print("============= system Repo Result Table ===============");
        if (response.statusCode == 200) {
          final tableData = response.data["data"];
          StoreX tables = StoreX(
            name: "tables",
            value: jsonEncode(tableData),
            // Encode the entire categoryData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final tableBox = store.box<StoreX>();

          // Check if the category record already exists
          final existingTable = tableBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("tables")))
              .build()
              .findFirst(); // Find first matching record

          if (existingTable != null) {
            // Record exists, update it
            tables.id =
                existingTable.id; // Ensure it has the same ID for updating
            tableBox.put(tables); // This will update the existing record
            print('Table record updated.');
          } else {
            // No record exists, insert new
            tableBox.put(tables); // This will insert a new record
            print('New tables record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchHotelCategories(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchHotelCategoriesAPI();
        print(
            "============= system Repo Result Hotel Categories ===============");

        if (response.statusCode == 200) {
          final categoryData = response.data["data"];

          StoreX hotelCategories = StoreX(
            name: "hotel_categories",
            value: jsonEncode(
                categoryData), // Encode the entire categoryData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final categoryBox = store.box<StoreX>();

          // Check if the category record already exists
          final existingCategory = categoryBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("hotel_categories")))
              .build()
              .findFirst(); // Find first matching record

          if (existingCategory != null) {
            // Record exists, update it
            hotelCategories.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox
                .put(hotelCategories); // This will update the existing record
            print('Hotel Category record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(hotelCategories); // This will insert a new record
            print('New Hotel category record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchHotelAmenities(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchHotelAmenitiesAPI();
        print(
            "============= system Repo Result Hotel Amenities ===============");

        if (response.statusCode == 200) {
          final categoryData = response.data["data"];

          StoreX hotelAmenities = StoreX(
            name: "hotel_amenities",
            value: jsonEncode(
                categoryData), // Encode the entire categoryData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final categoryBox = store.box<StoreX>();

          // Check if the category record already exists
          final existingCategory = categoryBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("hotel_amenities")))
              .build()
              .findFirst(); // Find first matching record

          if (existingCategory != null) {
            // Record exists, update it
            hotelAmenities.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox
                .put(hotelAmenities); // This will update the existing record
            print('Hotel Amenity record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(hotelAmenities); // This will insert a new record
            print('New Hotel amenity record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchHotelRooms(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchHotelRoomsAPI();
        print("============= system Repo Result Hotel Rooms ===============");
        print("hotel rooms data ==>> ${response.data["data"]}");
        if (response.statusCode == 200) {
          final categoryData = response.data["data"];

          StoreX hotelRooms = StoreX(
            name: "hotel_rooms",
            value: jsonEncode(
                categoryData), // Encode the entire categoryData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final categoryBox = store.box<StoreX>();

          // Check if the category record already exists
          final existingCategory = categoryBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("hotel_rooms")))
              .build()
              .findFirst(); // Find first matching record

          if (existingCategory != null) {
            // Record exists, update it
            hotelRooms.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox
                .put(hotelRooms); // This will update the existing record
            print('Hotel Room record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(hotelRooms); // This will insert a new record
            print('New Hotel room record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> fetchHotelReservations(
      bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchHotelReservationsAPI();
        print(
            "============= system Repo Result Hotel Reservations ===============");

        if (response.statusCode == 200) {
          final categoryData = response.data["data"];

          StoreX hotelReservations = StoreX(
            name: "hotel_reservations",
            value: jsonEncode(
                categoryData), // Encode the entire categoryData into JSON
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final categoryBox = store.box<StoreX>();

          // Check if the category record already exists
          final existingCategory = categoryBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("hotel_reservations")))
              .build()
              .findFirst(); // Find first matching record

          if (existingCategory != null) {
            // Record exists, update it
            hotelReservations.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox.put(
                hotelReservations); // This will update the existing record
            print('Hotel Reservations record updated.');
          } else {
            // No record exists, insert new
            categoryBox
                .put(hotelReservations); // This will insert a new record
            print('New Hotel reservation record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

// Future<bool> fetchProducts(bool refresh, bool connectionStatus, int? warehouseId) async {
//   print("Fetching products for warehouse: $warehouseId");
//   UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
  
//   try {
//     if (connectionStatus) {
//       _responseState = ResponseState.loading;
//       notifyListeners();
      
//       // **FIXED: Always fetch all products, then filter locally**
//       Response response = await SystemRepo(refresh: refresh, online: connectionStatus)
//           .fetchProductsAPI(id: null); // Fetch all products
      
//       print("Response ==>> $response");
//       print("============= system Repo Result Product ===============");
      
//       if (response.statusCode == 200) {
//         final productData = response.data["data"];
        
//         StoreX products = StoreX(
//           name: "products",
//           value: jsonEncode(productData),
//           billerId: user.id.toString(),
//           companyId: user.company!.id.toString(),
//           lastUpdated: DateTime.now().toIso8601String(),
//         );
        
//         final store = await DatabaseEngine.instance.getStore();
//         final productBox = store.box<StoreX>();
        
//         final existingProduct = productBox
//             .query(StoreX_.billerId
//                 .equals(user.id.toString())
//                 .and(StoreX_.name.equals("products")))
//             .build()
//             .findFirst();
        
//         if (existingProduct != null) {
//           products.id = existingProduct.id;
//           productBox.put(products);
//           print('Product record updated.');
//         } else {
//           productBox.put(products);
//           print('New Product record inserted.');
//         }
        
//         _responseState = ResponseState.done;
//         notifyListeners();
//         print('Successfully updated product records.');
//         return true;
//       } else {
//         print('Request failed with status: ${response.statusCode}.');
//       }
//     }
    
//     _responseState = ResponseState.error;
//     notifyListeners();
//     return false;
//   } catch (error) {
//     _responseState = ResponseState.error;
//     notifyListeners();
//     print(error);
//     return false;
//   }
// }



  Future<List<dynamic>> getCustomers() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getCustomers();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getRoomTypes() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).fetchRoomTypes();
      _roomTypesItems = response.data['data'];
      print("Fetched room data $response");
      return response.data;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<Map> getAvailableRooms(String roomTypeId, noOfAdult, noOfChildren,
      noOfRooms, startDate, endDate) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .fetchAvailableRooms(
              roomTypeId: roomTypeId,
              noOfAdult: noOfAdult,
              noOfChildren: noOfChildren,
              startDate: startDate,
              endDate: endDate,
              noOfRooms: noOfRooms);

      if (response.statusCode == 200) {
        _roomResult = response.data;
        print("Room search result ${roomResult['rooms']}");
        notifyListeners();
      }
      return response.data;
    } catch (error) {
      return {};
      // throw (error);
    }
  }

  Future<List<dynamic>> getCategories() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getCategories();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getTables() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getTables();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getHotelCategories() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getHotelCategories();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getHotelAmenities() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getHotelAmenities();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getHotelRooms() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getHotelRooms();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getHotelReservations() async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getHotelReservations();
      print("response ==>> $response");
      return response;
    } catch (error) {
      print(error.toString());
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getProducts(id) async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getProducts(id);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getWarehouse() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getWarehouses();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }


Future<List<dynamic>> getUserWarehouses() async {
  try {
    UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    
    // Check internet connectivity
    bool isConnected = await _checkInternetConnection();
    
    if (isConnected) {
      try {
        // Fetch from API using the get-user-warehouses endpoint
        var response = await SystemRepo(refresh: false, online: true).fetchUserWarehousesAPI();
        
        if (response.statusCode == 200) {
          final warehouseData = response.data["data"] ?? [];
          
          // Store in local database for offline access
          StoreX warehouses = StoreX(
            name: "user_warehouses",
            value: jsonEncode(warehouseData),
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );
          
          final store = await DatabaseEngine.instance.getStore();
          final warehouseBox = store.box<StoreX>();
          
          final existingWarehouse = warehouseBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("user_warehouses")))
              .build()
              .findFirst();
          
          if (existingWarehouse != null) {
            warehouses.id = existingWarehouse.id;
            warehouseBox.put(warehouses);
          } else {
            warehouseBox.put(warehouses);
          }
          
          print("✅ Successfully fetched user warehouses from API: ${warehouseData.length}");
          return warehouseData;
        } else {
          print("⚠️ API returned status ${response.statusCode}, falling back to local data");
        }
      } catch (apiError) {
        print("⚠️ API call failed: $apiError, falling back to local data");
      }
    } else {
      print("⚠️ No internet connection, using local data");
    }
    
    // Fallback to local data if API fails or no internet
    return await getLocalUserWarehouses();
  } catch (error) {
    print("❌ Error in getUserWarehouses: $error");
    // Final fallback to local data
    return await getLocalUserWarehouses();
  }
}

Future<List<dynamic>> getLocalUserWarehouses() async {
  try {
    UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final warehouseBox = store.box<StoreX>();
    
    final warehouses = warehouseBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals("user_warehouses")))
        .build()
        .findFirst();
    
    if (warehouses != null) {
      final List<dynamic> warehouseData = jsonDecode(warehouses.value) ?? [];
      print("✅ Retrieved ${warehouseData.length} user warehouses from local storage");
      return warehouseData;
    }
    
    print("⚠️ No user warehouses found in local storage");
    return [];
  } catch (error) {
    print("❌ Error getting local user warehouses: $error");
    return [];
  }
}


// **NEW: Method to get products by warehouse ID using the API**
Future<List<dynamic>> getProductsByWarehouse(int warehouseId) async {
  try {
    log("Fetching products for warehouse ID: $warehouseId from API");
    
    UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    
    // **FIXED: Use the warehouse-specific API endpoint**
    final String apiUrl = 'https://app.spotstockinventory.com/api/products?warehouse_id=$warehouseId';
    
    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.token}', // Make sure to use the user's token
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final products = data['data'] as List<dynamic>;
      
      log("Successfully fetched ${products.length} products for warehouse $warehouseId");
      
      // **FIXED: Cache the products locally for offline access**
      await _cacheWarehouseProducts(warehouseId, products);
      
      return products;
    } else {
      log("Failed to fetch products for warehouse $warehouseId: ${response.statusCode}");
      
      // **FIXED: Try to get cached products if API fails**
      return await _getCachedWarehouseProducts(warehouseId);
    }
  } catch (error) {
    log("Error fetching products for warehouse $warehouseId: $error");
    
    // **FIXED: Fallback to cached products if API fails**
    return await _getCachedWarehouseProducts(warehouseId);
  }
}

// **NEW: Cache warehouse products locally**
Future<void> _cacheWarehouseProducts(int warehouseId, List<dynamic> products) async {
  try {
    UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final storeBox = store.box<StoreX>();
    
    StoreX warehouseProducts = StoreX(
      name: "warehouse_products_$warehouseId",
      value: jsonEncode(products),
      billerId: user.id.toString(),
      companyId: user.company!.id.toString(),
      lastUpdated: DateTime.now().toIso8601String(),
    );
    
    final existingRecord = storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals("warehouse_products_$warehouseId")))
        .build()
        .findFirst();
    
    if (existingRecord != null) {
      warehouseProducts.id = existingRecord.id;
      storeBox.put(warehouseProducts);
      log('Updated cached products for warehouse $warehouseId');
    } else {
      storeBox.put(warehouseProducts);
      log('Cached new products for warehouse $warehouseId');
    }
  } catch (error) {
    log("Error caching products for warehouse $warehouseId: $error");
  }
}

// **NEW: Get cached warehouse products**
Future<List<dynamic>> _getCachedWarehouseProducts(int warehouseId) async {
  try {
    UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();
    final storeBox = store.box<StoreX>();
    
    final cachedProducts = storeBox
        .query(StoreX_.billerId
            .equals(user.id.toString())
            .and(StoreX_.name.equals("warehouse_products_$warehouseId")))
        .build()
        .findFirst();

    if (cachedProducts != null) {
      final List<dynamic> products = jsonDecode(cachedProducts.value) ?? [];
      log("Retrieved ${products.length} cached products for warehouse $warehouseId");
      return products;
    } else {
      log("No cached products found for warehouse $warehouseId");
      return [];
    }
  } catch (error) {
    log("Error retrieving cached products for warehouse $warehouseId: $error");
    return [];
  }
}

// **UPDATED: Modify the existing fetchProducts method to support warehouse-specific fetching**
Future<bool> fetchProducts(bool refresh, bool connectionStatus, int? warehouseId) async {
  log("Fetching products - refresh: $refresh, online: $connectionStatus, warehouseId: $warehouseId");
  UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
  
  try {
    if (connectionStatus) {
      _responseState = ResponseState.loading;
      notifyListeners();
      
      Response response;
      
      if (warehouseId != null) {
        // **NEW: Fetch products for specific warehouse**
        final String apiUrl = 'https://app.spotstockinventory.com/api/products?warehouse_id=$warehouseId';
        
        response = await Dio().get(
          apiUrl,
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${user.token}',
            },
          ),
        );
      } else {
        // **EXISTING: Fetch all products**
        response = await SystemRepo(refresh: refresh, online: connectionStatus)
            .fetchProductsAPI(id: null);
      }
      
      log("Response ==>> $response");
      log("============= system Repo Result Product ===============");
      
      if (response.statusCode == 200) {
        final productData = response.data["data"];
        
        String storeName = warehouseId != null ? "warehouse_products_$warehouseId" : "products";
        
        StoreX products = StoreX(
          name: storeName,
          value: jsonEncode(productData),
          billerId: user.id.toString(),
          companyId: user.company!.id.toString(),
          lastUpdated: DateTime.now().toIso8601String(),
        );
        
        final store = await DatabaseEngine.instance.getStore();
        final productBox = store.box<StoreX>();
        
        final existingProduct = productBox
            .query(StoreX_.billerId
                .equals(user.id.toString())
                .and(StoreX_.name.equals(storeName)))
            .build()
            .findFirst();
        
        if (existingProduct != null) {
          products.id = existingProduct.id;
          productBox.put(products);
          log('Product record updated for $storeName.');
        } else {
          productBox.put(products);
          log('New Product record inserted for $storeName.');
        }
        
        _responseState = ResponseState.done;
        notifyListeners();
        log('Successfully updated product records for $storeName.');
        return true;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    }
    
    _responseState = ResponseState.error;
    notifyListeners();
    return false;
  } catch (error) {
    _responseState = ResponseState.error;
    notifyListeners();
    log("Error in fetchProducts: $error");
    return false;
  }
}


// Future<List<dynamic>> getProductsByWarehouse(int warehouseId) async {
//   try {
//     UserDetails user = Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
//     final store = await DatabaseEngine.instance.getStore();
//     final storeBox = store.box<StoreX>();
    
//     final products = storeBox
//         .query(StoreX_.billerId
//             .equals(user.id.toString())
//             .and(StoreX_.name.equals('products')))
//         .build()
//         .findFirst();

//     if (products == null) {
//       print("No products found in local storage");
//       return [];
//     }

//     final List<dynamic> allProducts = jsonDecode(products.value) ?? [];
    
//     // Filter products by warehouse ID and stock availability
//     final filteredProducts = allProducts.where((product) {
//       try {
//         if (product == null || product['attributes'] == null) return false;
        
//         final attributes = product['attributes'];
//         final stock = attributes['stock'];
        
//         if (stock == null) return false;
        
//         final productWarehouseId = stock['warehouse_id'];
//         final quantity = stock['quantity'] ?? 0;
        
//         return productWarehouseId == warehouseId && quantity > 0;
//       } catch (e) {
//         print("Error filtering product: $e");
//         return false;
//       }
//     }).toList();

//     print("Filtered ${filteredProducts.length} products for warehouse $warehouseId");
//     return filteredProducts;
//   } catch (error) {
//     print("Error getting products by warehouse: $error");
//     return [];
//   }
// }
  


// Add this method to check internet connectivity (similar to AuthProvider)
Future<bool> _checkInternetConnection() async {
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3));
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (e) {
    print('Connectivity check failed: $e');
    return false;
  }
}

  Future<Map<String, dynamic>> getPrinters() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getPrinters();
      return response;
    } catch (error) {
      return {};
      // throw (error);
    }
  }

  Future<List<Orders>> getTransactionsByRegister(String? registerId) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getTransactionsByRegister(registerId: registerId);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<BookingX>> getBookingsByRegister(String? registerId) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getBookingsByRegister(registerId: registerId);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<Orders>> getTransactionsByDate(DateTime? selectedDate) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getTransactionsByDate(startDate: selectedDate);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<Register>> getAllRegisterByDate(
      DateTime? startDate, DateTime? endDate, String app) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getAllRegisterByDate(
              startDate: startDate, endDate: endDate, app: app);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<Register>> getAllRegisters({String? app}) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getAllRegisters(app: app!);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<Orders>> getWaitingSyncDate(DateTime? selectedDate) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getTransactionsByDate(startDate: selectedDate, sync: 0);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getInvoices(register) async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getInvoices(register);
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<bool> deleteInvoice(id) async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).deleteInvoice(id);
      return response;
    } catch (error) {
      return false;
      // throw (error);
    }
  }

  Future<bool> closeRegister(amount, app) async {
    try {
      print(amount);
      await SystemRepo(refresh: false, online: false)
          .closeRegister(app, amount);
      return true;
    } catch (error) {
      return false;
      // throw (error);
    }
  }

  Future<bool> clearInvoices() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).clearInvoices();
      return response;
    } catch (error) {
      return false;
      // throw (error);
    }
  }

  Future<Map<String, dynamic>> getReceiptTxn(String txnID) async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getReceiptTxn(txnID);
      return response;
    } catch (error) {
      return {};
      // throw (error);
    }
  }

  Future<Map<String, dynamic>> getHotelReceiptTxn(String txnID) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getHotelReceiptTxn(txnID);
      return response;
    } catch (error) {
      return {};
      // throw (error);
    }
  }

  Future<Map<String, dynamic>> getLastBookingRoom(String roomID) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getLastBookingRoom(roomID);
      return response;
    } catch (error) {
      return {};
      // throw (error);
    }
  }

  Future<Map<String, dynamic>> getCurrentRegister(
      {String? app = "INVENTORY"}) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getRegisterInfo(app: app);
      return response;
    } catch (error) {
      return {};
      // throw (error);
    }
  }

  Future<List<dynamic>> getTransactions() async {
    try {
      var response =
          await SystemRepo(refresh: false, online: false).getTransactions();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<List<dynamic>> getUnSyncTransactions() async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .getUnSyncTransactions();
      return response;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<Map<String, dynamic>> syncAllTransactions(UserDetails user) async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final orderBox = store.box<Orders>();
      final unsyncedOrders = orderBox.query(Orders_.sync.equals(0)).build().find();
      for (var order in unsyncedOrders) {
        var transactionData = _convertTransactionToSyncFormat(order);
        var response = await SystemRepo(refresh: false, online: true)
            .syncSingleTransaction(transactionData, user);
        if (response['status'] == true) {
          order.sync = 1;
          orderBox.put(order);
        }
      }
      await loadOrders(); // Refresh orders list
      notifyListeners();
      return {'status': true, 'message': 'Transactions synced successfully'};
    } catch (error) {
      print('Error syncing transactions: $error');
      return {
        'status': false,
        'message': 'Failed to sync transactions: $error',
      };
    }
  }


  Future<bool> fetchStaffs(bool refresh, bool connectionStatus) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchStaffsAPI();
        print("============= system Repo Result Staffs ===============");

        if (response.statusCode == 200) {
          final staffData = response.data["data"];

          StoreX staffs = StoreX(
            name: "staffs",
            value: jsonEncode(staffData),
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final staffBox = store.box<StoreX>();

          final existingStaff = staffBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("staffs")))
              .build()
              .findFirst();

          if (existingStaff != null) {
            staffs.id = existingStaff.id;
            staffBox.put(staffs);
            print('Staff record updated.');
          } else {
            staffBox.put(staffs);
            print('New staff record inserted.');
          }

          _responseState = ResponseState.done;
          notifyListeners();
          return true;
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      }

      _responseState = ResponseState.error;
      notifyListeners();
      return false;
    } catch (error) {
      _responseState = ResponseState.error;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<List<dynamic>> getStaffs() async {
    print('🔍 [DEBUG] getStaffs() called');

    try {
      UserDetails user =
          Provider.of<UserProvider>(Navigation.getContext(), listen: false)
              .user;
      print('🔍 [DEBUG] User ID: ${user.id}');

      final store = await DatabaseEngine.instance.getStore();
      final staffBox = store.box<StoreX>();

      final staffRecord = staffBox
          .query(StoreX_.billerId
              .equals(user.id.toString())
              .and(StoreX_.name.equals("staffs")))
          .build()
          .findFirst();

      if (staffRecord != null) {
        print('🔍 [DEBUG] Found staff record in database');
        print('🔍 [DEBUG] Staff record value: ${staffRecord.value}');

        final List<dynamic> staffs = jsonDecode(staffRecord.value);
        print('🔍 [DEBUG] Decoded staffs: ${staffs.length} items');
        return staffs;
      } else {
        print('⚠️ [WARNING] No staff record found in database');
        print('🔍 [DEBUG] Trying to fetch from API...');

        // Try to fetch from API if no local data
        bool connectionStatus = await InternetUtils.isConnected();
        if (connectionStatus) {
          print('🔍 [DEBUG] Internet available, fetching staffs...');
          await fetchStaffs(true, connectionStatus);

          // Try again to get from local storage
          final staffRecordRetry = staffBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("staffs")))
              .build()
              .findFirst();

          if (staffRecordRetry != null) {
            print('🔍 [DEBUG] Found staff record after API fetch');
            final List<dynamic> staffs = jsonDecode(staffRecordRetry.value);
            return staffs;
          }
        }

        return [];
      }
    } catch (error) {
      print("❌ [ERROR] getStaffs failed: $error");
      print("❌ [ERROR] Stack trace: ${StackTrace.current}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getAttendants() async {
    print('🔍 [DEBUG] getAttendants() called');

    try {
      var response = await getStaffs();
      print('🔍 [DEBUG] getStaffs() returned: ${response.length} items');
      print('🔍 [DEBUG] Raw staff data: $response');

      // Convert to the format expected by AttendantModel
      var converted = response.map<Map<String, dynamic>>((staff) {
        print('🔍 [DEBUG] Converting staff: $staff');
        return {
          'id': staff['id'].toString(),
          'name': staff['name'] ?? '',
          'department': staff['department'] ?? '',
          'pin_set': staff['pin_set'] ?? false,
          'pin': staff['pin'],
        };
      }).toList();

      print('🔍 [DEBUG] Converted attendants: $converted');
      return converted;
    } catch (error) {
      print('❌ [ERROR] getAttendants failed: $error');
      print('❌ [ERROR] Stack trace: ${StackTrace.current}');
      return [];
    }
  }


  // Add this method to handle individual transaction sync
  Future<Map<String, dynamic>> syncTransaction(Orders transaction) async {
    try {

      // Convert single transaction to the format expected by the API
      var transactionData = _convertTransactionToSyncFormat(transaction);
      
      // Use the existing sync method but with single transaction
      var response = await SystemRepo(refresh: false, online: false)
          .syncSingleTransaction(transactionData, _getCurrentUser());
      
      if (response['status'] == true) {
        // Update the transaction sync status locally
        final store = await DatabaseEngine.instance.getStore();
        final orderBox = store.box<Orders>();
        
        transaction.sync = 1;
        orderBox.put(transaction);
        
        notifyListeners();
      }
 
      return response;
    } catch (error) {
      print('Error syncing single transaction: $error');
      return {
        'status': false,
        'message': 'Failed to sync transaction: $error',
      };
    }
  }

  // Helper method to convert transaction to sync format
  Map<String, dynamic> _convertTransactionToSyncFormat(Orders transaction) {
    var items = jsonDecode(transaction.items);
    
    return {
      "company": {
        "id": transaction.billerId,
        "first_name": _getCurrentUser().firstName,
        "last_name": _getCurrentUser().lastName,
        "dob": '',
        "salary_date": ''
      },
      "customer_id": null,
      "date": transaction.createdAt.toIso8601String(),
      "discount": 0,
      "grand_total": transaction.amount.toString(),
      "hold_ref_no": "",
      "note": "",
      "payment_status": transaction.status,
      "payment_type": transaction.paymentMethod,
      "received_amount": int.parse(transaction.amount.toString().replaceAll('.0', '')),
      "sale_items": items
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
      "status": transaction.status,
      "tax_rate": 0,
      "warehouse_id": items[0]['product']['stock']['warehouse_id'],
      "is_offline": 1,
      "offline_customer_name": transaction.customerName
    };
  }

  // Helper method to get current user
  UserDetails _getCurrentUser() {
    return Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
  }

// Method to get active bookings for folio payments
Future<List<dynamic>> getActiveBookings() async {
  try {
    // This should call your API endpoint for active bookings
    // For now, returning mock data structure
    return [
      {
        'id': 1,
        'booking_number': 'BK001',
        'customer_name': 'John Doe',
        'check_in': '2024-01-15',
        'check_out': '2024-01-20',
        'status': 'active',
        'folio_balance': 5000.0,
        'booked_rooms': [
          {
            'id': 1,
            'room_id': 101,
            'room_name': 'Room 101 - Deluxe',
            'status': 'active',
          },
          {
            'id': 2,
            'room_id': 102,
            'room_name': 'Room 102 - Standard',
            'status': 'active',
          },
        ],
      },
      // Add more mock bookings as needed
    ];
  } catch (error) {
    print("Error getting active bookings: $error");
    return [];
  }
}
}