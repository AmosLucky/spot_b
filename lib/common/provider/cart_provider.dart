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
      // **NEW: Immediately sync the transaction to sales API**
      try {
        await _syncTransactionToSales(response['txnID'], paymentData, subTotal, json);
      } catch (e) {
        print('Warning: Failed to sync transaction to sales: $e');
        // Don't fail the checkout if sync fails
      }
      
      removeAll();
    }
    return response;
  }

  // **NEW: Method to sync transaction to sales API immediately**
  Future<void> _syncTransactionToSales(String txnID, Map<String, dynamic> paymentData, double subTotal, String itemsJson) async {
    try {
      final systemRepo = SystemRepo(refresh: false, online: true);
      
      // Convert cart items to sale items format
      final List<dynamic> cartItems = jsonDecode(itemsJson);
      final List<Map<String, dynamic>> saleItems = cartItems.map((item) => {
        'product_id': item['product']['stock']['product_id'],
        'quantity': item['quantity'],
        'product_price': item['totalAmount'].toString(),
        'discount_type': 1,
        'discount_value': 0,
        'tax_value': 0,
        'tax_type': 1,
      }).toList();

      // Prepare sale data in the format expected by the API
      final saleData = {
        'customer_id': null,
        'date': DateTime.now().toIso8601String(),
        'discount': 0,
        'grand_total': subTotal.toString(),
        'hold_ref_no': '',
        'note': '',
        'payment_status': _getPaymentStatusCode(paymentData['paymentStatus']),
        'payment_type': paymentData['paymentType'] ?? 'Cash',
        'received_amount': (paymentData['receivedAmount'] ?? subTotal).toInt(),
        'sale_items': saleItems,
        'shipping': 0,
        'status': 1,
        'tax_rate': 0,
        'warehouse_id': cartItems.isNotEmpty ? cartItems[0]['product']['stock']['warehouse_id'] : null,
        'is_offline': 0,
        'offline_customer_name': paymentData['customerName'] ?? 'Walk-in Customer',
        'attendant_id': paymentData['attendantId'],
        'reference_code': paymentData['invoiceReference'],
        'table_id': paymentData['table'],
      };

      // Sync to sales API
      await systemRepo.syncSaleTransaction(saleData);
      print('✅ Transaction synced to sales API successfully');
      
    } catch (e) {
      print('❌ Failed to sync transaction to sales API: $e');
      rethrow;
    }
  }

  int _getPaymentStatusCode(String? status) {
    switch (status) {
      case 'Paid':
        return 1;
      case 'Unpaid':
        return 2;
      case 'Partial':
        return 3;
      default:
        return 1;
    }
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

  // In cart_provider.dart, when calling holdInvoice, ensure attendantId is passed as String
  Future<Map<String, dynamic>> holdInvoice(
      BuildContext context,
      registerId,
      subTotal,
      table,
      customerName,
      customerPhone,
      {String? attendantId}) async { // Parameter is already String? which is correct
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

//   // New properties for tracking invoice state
//   String? _currentInvoiceReference;
//   String? get currentInvoiceReference => _currentInvoiceReference;

//   String? _currentAttendantId;
//   String? get currentAttendantId => _currentAttendantId;

//   String? _currentCustomerName;
//   String? get currentCustomerName => _currentCustomerName;

//   bool _isRedoingInvoice = false;
//   bool get isRedoingInvoice => _isRedoingInvoice;

//   add(Map product, int index, String trackID, int amount, int qty,
//       String productCode) {
//     // Check if the product already exists in the cart based on its trackID
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
//     _selectedInvoiceId = 0;
//     _isRedoingInvoice = false;
//     _currentInvoiceReference = null;
//     _currentAttendantId = null;
//     _currentCustomerName = null;
//     notifyListeners();
//   }

//   // Updated redoInvoice method to preserve original reference and track state
//   void redoInvoice(String json, int id, int index, {String? originalReference, String? attendantId, String? customerName}) {
//     try {
//       // Decode the JSON string into a list of items
//       List<dynamic> decodedItems = jsonDecode(json);
//       // Map the decoded items to CartModel instances and update the items list
//       items = decodedItems.map((item) => CartModel.fromJson(item)).toList();
      
//       // Set the redo state and preserve original invoice data
//       _totalCart = items.length;
//       _selectedInvoiceId = id;
//       _selectedIndex = index;
//       _isRedoingInvoice = true;
//       _currentInvoiceReference = originalReference;
//       _currentAttendantId = attendantId;
//       _currentCustomerName = customerName;
      
//       totalPriceSum();
//       // Notify listeners to update the UI
//       notifyListeners();
//     } catch (e) {
//       print("Error redoing invoice: $e");
//     }
//   }

//   // Generate unique invoice reference based on attendant and customer
//   String _generateUniqueInvoiceReference(String? attendantId, String customerName) {
//     if (_isRedoingInvoice && _currentInvoiceReference != null) {
//       return _currentInvoiceReference!;
//     }
    
//     final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
//     final attendantPrefix = attendantId?.substring(0, 2).toUpperCase() ?? 'WI';
//     final customerPrefix = customerName.substring(0, 2).toUpperCase();
//     final randomSuffix = generateRandomStringForInvoice(4);
    
//     return '$attendantPrefix$customerPrefix$timestamp$randomSuffix';
//   }

//   void incrementQuantity(int index) {
//     items[index].quantity++;
//     totalPriceSum();
//     notifyListeners();
//   }

//   void updateQuantity(int index, quantityValue) {
//     items[index].quantity = quantityValue;
//     totalPriceSum();
//     notifyListeners();
//   }

//   void decrementQuantity(int index) {
//     if (items[index].quantity > 1) {
//       items[index].quantity--;
//       totalPriceSum();
//       notifyListeners();
//     }
//   }

//   double getTotalPrice() {
//     return items.fold(
//         0.0, (sum, product) => sum + (product.totalAmount! * product.quantity));
//   }

//   totalPriceSum() {
//     _subTotal = getTotalPrice();
//   }

//   Future<Map<String, dynamic>> checkout(
//       BuildContext context, subTotal, paymentData) async {
//     var json = jsonEncode(items.map((e) => e.toJson()).toList());
//     print("========= final item =============");
//     print(json);
    
//     // Generate or use existing invoice reference
//     final invoiceReference = _generateUniqueInvoiceReference(
//       paymentData['attendantId'], 
//       paymentData['customerName'] ?? 'Walk-in Customer'
//     );
//     paymentData['invoiceReference'] = invoiceReference;
    
//     var response = await SystemRepo(refresh: false, online: false)
//         .checkout(paymentData, subTotal, json);
//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   }

//   Future<Map<String, dynamic>> checkoutBooking(
//       BuildContext context, subTotal, paymentData, booking) async {
//     var json = jsonEncode(items.map((e) => e.toJson()).toList());
//     print("========= final item =============");
//     print(json);
//     var response = await SystemRepo(refresh: false, online: false)
//         .checkoutBooking(paymentData, subTotal, json, booking);
//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   }

// // In cart_provider.dart, when calling holdInvoice, ensure attendantId is passed as String
// Future<Map<String, dynamic>> holdInvoice(
//     BuildContext context,
//     registerId,
//     subTotal,
//     table,
//     customerName,
//     customerPhone,
//     {String? attendantId}) async { // Parameter is already String? which is correct

//   var json = jsonEncode(items.map((e) => e.toJson()).toList());
//   print("========= final item =============");
//   print(json);

//   String invoiceReference;

//   if (_isRedoingInvoice && _currentInvoiceReference != null) {
//     // Use existing reference for redo operations
//     invoiceReference = _currentInvoiceReference!;

//     // Update existing invoice instead of creating new one
//     var response = await SystemRepo(refresh: false, online: false)
//         .updateInvoice(_selectedInvoiceId, subTotal, json, table, customerName, customerPhone, attendantId);

//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   } else {
//     // Generate new reference for new invoices
//     invoiceReference = _generateUniqueInvoiceReference(attendantId, customerName ?? 'Walk-in Customer');

//     var response = await SystemRepo(refresh: false, online: false)
//         .holdInvoice(subTotal, registerId, json, table, customerName, customerPhone, attendantId, invoiceReference);

//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   }
// }


//   summary(BuildContext context, SystemProvider systemProvider, String customer,
//       data) {
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
//     _selectedInvoiceId = 0;
//     _isRedoingInvoice = false;
//     _currentInvoiceReference = null;
//     _currentAttendantId = null;
//     _currentCustomerName = null;
//     print("-------- new items ----------");
//     print(items);
//     notifyListeners();
//   }

//   del(int index) {
//     items.removeAt(index);
//     _totalCart = items.length;
//     totalPriceSum();
//     notifyListeners();
//   }
// }

// // Helper function to generate random string
// String generateRandomStringForInvoice(int length) {
//   const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//   return List.generate(length, (index) => chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length]).join();
// }