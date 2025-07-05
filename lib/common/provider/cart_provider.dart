import 'dart:convert';
import 'package:spotstock_inventory/data/models/cart.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/screens/mobile/pos/summary_mobile.dart';
import 'package:flutter/material.dart';
import 'system_provider.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> items = [];
  double _subTotal = 0.0;
  double get subTotal => _subTotal;

  int _selectedInvoiceId = 0;
  int get selectedInvoiceId => _selectedInvoiceId;

  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  num _totalCart = 0;
  num get totalCart => _totalCart;

  // New properties for tracking invoice state
  String? _currentInvoiceReference;
  String? get currentInvoiceReference => _currentInvoiceReference;

  String? _currentAttendantId;
  String? get currentAttendantId => _currentAttendantId;

  String? _currentCustomerName;
  String? get currentCustomerName => _currentCustomerName;

  bool _isRedoingInvoice = false;
  bool get isRedoingInvoice => _isRedoingInvoice;

  add(Map product, int index, String trackID, int amount, int qty,
      String productCode) {
    // Check if the product already exists in the cart based on its trackID
    int inddex = items
        .indexWhere((item) => item.product?['product_code'] == productCode);
    if (inddex != -1) {
      // If the product is found, increase its quantity
      items[inddex].quantity += qty;
    } else {
      // If the product is not in the cart, add it as a new item
      items.add(CartModel(
          id: index,
          product: product,
          trackID: trackID,
          totalAmount: amount,
          quantity: qty));
    }

    // Update the total number of items in the cart and notify listeners
    _totalCart = items.length;
    totalPriceSum();
    notifyListeners();
  }

  void updateProduct(Map product, String index, int amount, int qty) {
    final itemIndex = items.indexWhere((prod) => prod.trackID == index);
    print("========= new item =============");
    if (items.contains(items[itemIndex])) {
      items[itemIndex] = CartModel(
          product: product, trackID: index, totalAmount: amount, quantity: qty);
    }
    print("========= new item =============");
    print(items[itemIndex].quantity);
    totalPriceSum();
    notifyListeners();
  }

  void updateProductPrice(String index, int newPrice) {
    final itemIndex = items.indexWhere((prod) => prod.trackID == index);
    if (itemIndex != -1) {
      items[itemIndex].totalAmount = newPrice * items[itemIndex].quantity;
      if (items[itemIndex].product != null) {
        items[itemIndex].product!['product_price'] = newPrice;
      }
      totalPriceSum();
      notifyListeners();
    }
  }

  void deleteIndex() {
    _selectedIndex = null;
    _selectedInvoiceId = 0;
    _isRedoingInvoice = false;
    _currentInvoiceReference = null;
    _currentAttendantId = null;
    _currentCustomerName = null;
    notifyListeners();
  }

  // Updated redoInvoice method to preserve original reference and track state
  void redoInvoice(String json, int id, int index, {String? originalReference, String? attendantId, String? customerName}) {
    try {
      // Decode the JSON string into a list of items
      List<dynamic> decodedItems = jsonDecode(json);
      // Map the decoded items to CartModel instances and update the items list
      items = decodedItems.map((item) => CartModel.fromJson(item)).toList();
      
      // Set the redo state and preserve original invoice data
      _totalCart = items.length;
      _selectedInvoiceId = id;
      _selectedIndex = index;
      _isRedoingInvoice = true;
      _currentInvoiceReference = originalReference;
      _currentAttendantId = attendantId;
      _currentCustomerName = customerName;
      
      totalPriceSum();
      // Notify listeners to update the UI
      notifyListeners();
    } catch (e) {
      print("Error redoing invoice: $e");
    }
  }

  // Generate unique invoice reference based on attendant and customer
  String _generateUniqueInvoiceReference(String? attendantId, String customerName) {
    if (_isRedoingInvoice && _currentInvoiceReference != null) {
      return _currentInvoiceReference!;
    }
    
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final attendantPrefix = attendantId?.substring(0, 2).toUpperCase() ?? 'WI';
    final customerPrefix = customerName.substring(0, 2).toUpperCase();
    final randomSuffix = generateRandomStringForInvoice(4);
    
    return '$attendantPrefix$customerPrefix$timestamp$randomSuffix';
  }

  void incrementQuantity(int index) {
    items[index].quantity++;
    totalPriceSum();
    notifyListeners();
  }

  void updateQuantity(int index, quantityValue) {
    items[index].quantity = quantityValue;
    totalPriceSum();
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
      totalPriceSum();
      notifyListeners();
    }
  }

  double getTotalPrice() {
    return items.fold(
        0.0, (sum, product) => sum + (product.totalAmount! * product.quantity));
  }

  totalPriceSum() {
    _subTotal = getTotalPrice();
  }

  Future<Map<String, dynamic>> checkout(
      BuildContext context, subTotal, paymentData) async {
    var json = jsonEncode(items.map((e) => e.toJson()).toList());
    print("========= final item =============");
    print(json);
    
    // Generate or use existing invoice reference
    final invoiceReference = _generateUniqueInvoiceReference(
      paymentData['attendantId'], 
      paymentData['customerName'] ?? 'Walk-in Customer'
    );
    paymentData['invoiceReference'] = invoiceReference;
    
    var response = await SystemRepo(refresh: false, online: false)
        .checkout(paymentData, subTotal, json);
    if (response['status'] == true) {
      removeAll();
    }
    return response;
  }

  Future<Map<String, dynamic>> checkoutBooking(
      BuildContext context, subTotal, paymentData, booking) async {
    var json = jsonEncode(items.map((e) => e.toJson()).toList());
    print("========= final item =============");
    print(json);
    var response = await SystemRepo(refresh: false, online: false)
        .checkoutBooking(paymentData, subTotal, json, booking);
    if (response['status'] == true) {
      removeAll();
    }
    return response;
  }

  // Updated holdInvoice method to handle redo state
  Future<Map<String, dynamic>> holdInvoice(
      BuildContext context, 
      registerId, 
      subTotal, 
      table, 
      customerName, 
      customerPhone, 
      {String? attendantId}) async {
    
    var json = jsonEncode(items.map((e) => e.toJson()).toList());
    print("========= final item =============");
    print(json);
    
    String invoiceReference;
    
    if (_isRedoingInvoice && _currentInvoiceReference != null) {
      // Use existing reference for redo operations
      invoiceReference = _currentInvoiceReference!;
      
      // Update existing invoice instead of creating new one
      var response = await SystemRepo(refresh: false, online: false)
          .updateInvoice(_selectedInvoiceId, subTotal, json, table, customerName, customerPhone, attendantId);
      
      if (response['status'] == true) {
        removeAll();
      }
      return response;
    } else {
      // Generate new reference for new invoices
      invoiceReference = _generateUniqueInvoiceReference(attendantId, customerName ?? 'Walk-in Customer');
      
      var response = await SystemRepo(refresh: false, online: false)
          .holdInvoice(subTotal, registerId, json, table, customerName, customerPhone, attendantId, invoiceReference);
      
      if (response['status'] == true) {
        removeAll();
      }
      return response;
    }
  }

  summary(BuildContext context, SystemProvider systemProvider, String customer,
      data) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SummaryMobile(
              systemProvider: systemProvider,
              data: data,
              customer: customer,
            )));
  }

  removeAll() {
    items.clear();
    _totalCart = items.length;
    _subTotal = 0;
    _selectedIndex = null;
    _selectedInvoiceId = 0;
    _isRedoingInvoice = false;
    _currentInvoiceReference = null;
    _currentAttendantId = null;
    _currentCustomerName = null;
    print("-------- new items ----------");
    print(items);
    notifyListeners();
  }

  del(int index) {
    items.removeAt(index);
    _totalCart = items.length;
    totalPriceSum();
    notifyListeners();
  }
}

// Helper function to generate random string
String generateRandomStringForInvoice(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return List.generate(length, (index) => chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length]).join();
}




// import 'dart:convert';

// import 'package:spotstock_inventory/data/models/cart.dart';
// import 'package:spotstock_inventory/data/repository/system_repo.dart';
// import 'package:spotstock_inventory/screens/mobile/pos/summary_mobile.dart';
// import 'package:flutter/material.dart';

// import 'system_provider.dart';

// class CartProvider with ChangeNotifier {
//   List<CartModel> items = [];
//   double _subTotal = 0.0;
//   double get subTotal => _subTotal;
//   int _selectedInvoiceId = 0;
//   int get selectedInvoiceId => _selectedInvoiceId;
//   int? _selectedIndex;
//   int? get selectedIndex => _selectedIndex;
//   num _totalCart = 0;
//   num get totalCart => _totalCart;

//   add(Map product, int index, String trackID, int amount, int qty,
//       String productCode) {
//     // Check if the product already exists in the cart based on its trackID
//     // final existingProductIndex = items.indexWhere((prod) {
//     //   //print(prod.id);
//     //   return prod.trackID == index;});

//     int inddex = items
//         .indexWhere((item) => item.product?['product_code'] == productCode);

//     if (inddex != -1) {
//       // If the product is found, increase its quantity
//       items[inddex].quantity += qty;
//     } else {
//       // If the product is not in the cart, add it as a new item
//       items.add(CartModel(
//           id: index,
//           product: product,
//           trackID: trackID,
//           totalAmount: amount,
//           quantity: qty));
//     }

//     // Update the total number of items in the cart and notify listeners
//     _totalCart = items.length;
//     totalPriceSum();
//     notifyListeners();
//   }

//   void updateProduct(Map product, String index, int amount, int qty) {
//     final itemIndex = items.indexWhere((prod) => prod.trackID == index);
//     print("========= new item =============");
//     // var totalAmount = qty * amount;
//     if (items.contains(items[itemIndex])) {
//       items[itemIndex] = CartModel(
//           product: product, trackID: index, totalAmount: amount, quantity: qty);
//     }
//     print("========= new item =============");
//     print(items[itemIndex].quantity);
//     totalPriceSum();
//     notifyListeners();
//   }

//   void updateProductPrice(String index, int newPrice) {
//     final itemIndex = items.indexWhere((prod) => prod.trackID == index);
//     if (itemIndex != -1) {
//       items[itemIndex].totalAmount = newPrice * items[itemIndex].quantity;
//       if (items[itemIndex].product != null) {
//         items[itemIndex].product!['product_price'] = newPrice;
//       }
//       totalPriceSum();
//       notifyListeners();
//     }
//   }

//   void deleteIndex() {
//     _selectedIndex = null;
//     notifyListeners();
//   }

//   void redoInvoice(String json, int id, int index) {
//     try {
//       // Decode the JSON string into a list of items
//       List<dynamic> decodedItems = jsonDecode(json);

//       // Map the decoded items to CartModel instances and update the items list
//       items = decodedItems.map((item) => CartModel.fromJson(item)).toList();

//       // Recalculate the total cart items and subtotal
//       _totalCart = items.length;
//       _selectedInvoiceId = id;
//       _selectedIndex = index;
//       totalPriceSum();

//       // Notify listeners to update the UI
//       notifyListeners();
//     } catch (e) {
//       print("Error redoing invoice: $e");
//     }
//   }

//   void incrementQuantity(int index) {
//     items[index].quantity++;
//     totalPriceSum(); // Update subtotal when quantity is incremented
//     notifyListeners();
//   }

//   void updateQuantity(int index, quantityValue) {
//     items[index].quantity = quantityValue;
//     totalPriceSum(); // Update subtotal when quantity is incremented
//     notifyListeners();
//   }

//   void decrementQuantity(int index) {
//     if (items[index].quantity > 1) {
//       items[index].quantity--;
//       totalPriceSum(); // Update subtotal when quantity is decremented
//       notifyListeners();
//     }
//   }

//   double getTotalPrice() {
//     return items.fold(
//         0.0, (sum, product) => sum + (product.totalAmount! * product.quantity));
//   }

//   totalPriceSum() {
//     // var amount = items
//     //     .map((item) => item.totalAmount! * item.quantity!)
//     //     .reduce((ele1, ele2) => ele1 + ele2);
//     // _totalCart = items.length;
//     _subTotal = getTotalPrice();
//   }

//   Future<Map<String, dynamic>> checkout(
//       BuildContext context, subTotal, paymentData) async {
//     // save records to local storage and online
//     // Navigator.of(context)
//     //     .push(MaterialPageRoute(builder: (_) => const SearchCategory()));
//     var json = jsonEncode(items.map((e) => e.toJson()).toList());
//     print("========= final item =============");
//     print(json);
//     var response = await SystemRepo(refresh: false, online: false)
//         .checkout(paymentData, subTotal, json);
//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   }

//   Future<Map<String, dynamic>> checkoutBooking(
//       BuildContext context, subTotal, paymentData, booking) async {
//     // save records to local storage and online
//     // Navigator.of(context)
//     //     .push(MaterialPageRoute(builder: (_) => const SearchCategory()));
//     var json = jsonEncode(items.map((e) => e.toJson()).toList());
//     print("========= final item =============");
//     print(json);
//     var response = await SystemRepo(refresh: false, online: false)
//         .checkoutBooking(paymentData, subTotal, json, booking);
//     if (response['status'] == true) {
//       // update the room
//       removeAll();
//     }
//     return response;
//   }

//   Future<Map<String, dynamic>> holdInvoice(
//       BuildContext context, registerId, subTotal, table, customerName, customerPhone) async {
//     // save records to local storage and online
//     // Navigator.of(context)
//     //     .push(MaterialPageRoute(builder: (_) => const SearchCategory()));
//     var json = jsonEncode(items.map((e) => e.toJson()).toList());
//     print("========= final item =============");
//     print(json);
//     var response = await SystemRepo(refresh: false, online: false)
//         .holdInvoice(subTotal, registerId, json, table, customerName, customerPhone);
//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   }

//   summary(BuildContext context, SystemProvider systemProvider, String customer,
//       data) {
//     // save records to local storage and online
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => SummaryMobile(
//               systemProvider: systemProvider,
//               data: data,
//               customer: customer,
//             )));
//   }

//   removeAll() {
//     items.clear();
//     _totalCart = items.length;
//     _subTotal = 0;
//     _selectedIndex = null;
//     print("-------- new items ----------");
//     print(items);
//     notifyListeners();
//   }

//   del(int index) {
//     items.removeAt(index);
//     _totalCart = items.length;
//     // Recalculate the subtotal after removing the item
//     totalPriceSum();
//     notifyListeners();
//   }
// }