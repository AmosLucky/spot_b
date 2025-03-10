// import 'dart:convert';
//
// import 'package:spotstock_inventory/data/models/cart.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/data/repository/system_repo.dart';
// import 'package:spotstock_inventory/screens/mobile/pos/summary_mobile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// import '../../data/models/booking.dart';
// import 'system_provider.dart';
//
// class BookingProvider with ChangeNotifier {
//   List<BookingModel> items = [];
//   double _subTotal = 0.0;
//   double get subTotal => _subTotal;
//   num _totalCart = 0;
//   num get totalCart => _totalCart;
//
//   add(Map product, int index, String trackID, int amount, int qty, String productCode) {
//     // Check if the product already exists in the cart based on its trackID
//     // final existingProductIndex = items.indexWhere((prod) {
//     //   //print(prod.id);
//     //   return prod.trackID == index;});
//
//     int inddex = items.indexWhere((item) => item.room?['product_code'] == productCode);
//
//     if (inddex != -1) {
//       // If the product is found, increase its quantity
//       items[inddex].quantity += qty;
//     } else {
//       // If the product is not in the cart, add it as a new item
//       items.add(BookingModel(
//           id: index,
//           room: product,
//           trackID: trackID,
//           totalAmount: amount,
//           quantity: qty));
//     }
//
//     // Update the total number of items in the cart and notify listeners
//     _totalCart = items.length;
//     totalPriceSum();
//     notifyListeners();
//   }
//
//   void updateProduct(Map product, String index, int amount, int qty) {
//     final itemIndex = items.indexWhere((prod) => prod.trackID == index);
//     print("========= new item =============");
//     // var totalAmount = qty * amount;
//     if (items.contains(items[itemIndex])) {
//       items[itemIndex] = BookingModel(
//           room: product, trackID: index, totalAmount: amount, quantity: qty);
//     }
//     print("========= new item =============");
//     print(items[itemIndex].quantity);
//     totalPriceSum();
//     notifyListeners();
//   }
//
//   void updateProductPrice(String index, int newPrice) {
//     final itemIndex = items.indexWhere((prod) => prod.trackID == index);
//     if (itemIndex != -1) {
//       items[itemIndex].totalAmount = newPrice * items[itemIndex].quantity;
//       if (items[itemIndex].room != null) {
//         items[itemIndex].room!['product_price'] = newPrice;
//       }
//       totalPriceSum();
//       notifyListeners();
//     }
//   }
//
//   void redoInvoice(String json) {
//     try {
//       // Decode the JSON string into a list of items
//       List<dynamic> decodedItems = jsonDecode(json);
//
//       // Map the decoded items to CartModel instances and update the items list
//       items = decodedItems.map((item) => BookingModel.fromJson(item)).toList();
//
//       // Recalculate the total cart items and subtotal
//       _totalCart = items.length;
//       totalPriceSum();
//
//       // Notify listeners to update the UI
//       notifyListeners();
//     } catch (e) {
//       print("Error redoing invoice: $e");
//     }
//   }
//
//   void incrementQuantity(int index) {
//     items[index].quantity++;
//     totalPriceSum(); // Update subtotal when quantity is incremented
//     notifyListeners();
//   }
//
//   void decrementQuantity(int index) {
//     if (items[index].quantity > 1) {
//       items[index].quantity--;
//       totalPriceSum(); // Update subtotal when quantity is decremented
//       notifyListeners();
//     }
//   }
//
//   // double getTotalPrice() {
//   //   return items.fold(
//   //       0.0, (sum, room) => sum + (room.totalAmount! * product.quantity));
//   // }
//
//   totalPriceSum() {
//     // var amount = items
//     //     .map((item) => item.totalAmount! * item.quantity!)
//     //     .reduce((ele1, ele2) => ele1 + ele2);
//     // _totalCart = items.length;
//     _subTotal = getTotalPrice();
//   }
//
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
//
//   Future<Map<String, dynamic>> holdInvoice(
//       BuildContext context, registerId, subTotal) async {
//     // save records to local storage and online
//     // Navigator.of(context)
//     //     .push(MaterialPageRoute(builder: (_) => const SearchCategory()));
//     var json = jsonEncode(items.map((e) => e.toJson()).toList());
//     print("========= final item =============");
//     print(json);
//     var response = await SystemRepo(refresh: false, online: false)
//         .holdInvoice(subTotal, registerId, json);
//     if (response['status'] == true) {
//       removeAll();
//     }
//     return response;
//   }
//
//   summary(BuildContext context, SystemProvider systemProvider, String customer,
//       data) {
//     // save records to local storage and online
//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => SummaryMobile(
//           systemProvider: systemProvider,
//           data: data,
//           customer: customer,
//         )));
//   }
//
//   removeAll() {
//     items.clear();
//     _totalCart = items.length;
//     _subTotal = 0;
//     print("-------- new items ----------");
//     print(items);
//     notifyListeners();
//   }
//
//   del(int index) {
//     items.removeAt(index);
//     _totalCart = items.length;
//     // Recalculate the subtotal after removing the item
//     totalPriceSum();
//     notifyListeners();
//   }
// }
