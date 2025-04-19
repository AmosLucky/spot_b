import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
import 'package:spotstock_inventory/common/navigation.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/objectbox.g.dart';

import 'response_state.dart';
import 'user_provider.dart';

class SystemProvider with ChangeNotifier {
  // List<NameModel> _items = [];
  SystemProvider() {
    _getDashboardFeed();
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

          _warehouseIds =  response.data['data'][0]['id'];
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

          StoreX hotel_categories = StoreX(
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
            hotel_categories.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox
                .put(hotel_categories); // This will update the existing record
            print('Hotel Category record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(hotel_categories); // This will insert a new record
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

          StoreX hotel_amenities = StoreX(
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
            hotel_amenities.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox
                .put(hotel_amenities); // This will update the existing record
            print('Hotel Amenity record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(hotel_amenities); // This will insert a new record
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

          StoreX hotel_rooms = StoreX(
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
            hotel_rooms.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox
                .put(hotel_rooms); // This will update the existing record
            print('Hotel Room record updated.');
          } else {
            // No record exists, insert new
            categoryBox.put(hotel_rooms); // This will insert a new record
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

          StoreX hotel_reservations = StoreX(
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
            hotel_reservations.id =
                existingCategory.id; // Ensure it has the same ID for updating
            categoryBox.put(
                hotel_reservations); // This will update the existing record
            print('Hotel Reservations record updated.');
          } else {
            // No record exists, insert new
            categoryBox
                .put(hotel_reservations); // This will insert a new record
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

  Future<bool> fetchProducts(bool refresh, bool connectionStatus, int? warehouseId) async {
    print("Fetching products");
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    try {
      if (connectionStatus) {
        _responseState = ResponseState.loading;
        notifyListeners();

        Response response =
            await SystemRepo(refresh: refresh, online: connectionStatus)
                .fetchProductsAPI(id: warehouseId);
        print("Response ==>> ${response}");
        print("============= system Repo Result Product ===============");

        if (response.statusCode == 200) {
          final productData = response.data["data"];

          StoreX products = StoreX(
            name: "products",
            value: jsonEncode(productData),
            billerId: user.id.toString(),
            companyId: user.company!.id.toString(),
            lastUpdated: DateTime.now().toIso8601String(),
          );

          final store = await DatabaseEngine.instance.getStore();
          final productBox = store.box<StoreX>();

          // Check if the product record already exists
          final existingProduct = productBox
              .query(StoreX_.billerId
                  .equals(user.id.toString())
                  .and(StoreX_.name.equals("products")))
              .build()
              .findFirst(); // Find first matching record

          if (existingProduct != null) {
            // Record exists, update it
            products.id =
                existingProduct.id; // Ensure it has the same ID for updating
            productBox.put(products); // This will update the existing record
            print('Product record updated.');
          } else {
            // No record exists, insert new
            productBox.put(products); // This will insert a new record
            print('New Product record inserted.');
          }

          // productBox.removeAll(); // Clear existing products

          _responseState = ResponseState.done;
          notifyListeners();
          print('Successfully updated product records.');
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
      var response = await SystemRepo(refresh: false, online: false).fetchRoomTypes();
      _roomTypesItems = response.data['data'];
      print("Fetched room data ${response}");
      return response.data;
    } catch (error) {
      return [];
      // throw (error);
    }
  }

  Future<Map> getAvailableRooms(String roomTypeId, noOfAdult, noOfChildren, noOfRooms, startDate, endDate) async {
    try {
      var response = await SystemRepo(refresh: false, online: false).fetchAvailableRooms(roomTypeId: roomTypeId, noOfAdult: noOfAdult, noOfChildren: noOfChildren, startDate: startDate, endDate: endDate, noOfRooms: noOfRooms);

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

  // Future<List<Booking>> getHotelTransactionsByRegister(String? registerId) async {
  //   try {
  //     var response = await SystemRepo(refresh: false, online: false)
  //         .getHotelTransactionsByRegister(registerId: registerId);
  //     return response;
  //   } catch (error) {
  //     return [];
  //     // throw (error);
  //   }
  // }

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

  Future<Map<String, dynamic>> syncAllTransactions(UserDetails user,) async {
    try {
      var response = await SystemRepo(refresh: false, online: false)
          .syncAllTransactions(user,);
      return response;
    } catch (error) {
      return {};
      // throw (error);
    }
  }
}
