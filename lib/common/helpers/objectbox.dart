import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/objectbox.g.dart';
import 'package:spotstock_inventory/screens/desktop/model/select_attendant_model.dart';

class ObjectBox {
  late final Store store;

  late final Box<Orders> orderBox;
  late final Box<StoreX> storeXBox;
  late final Box<TableList> tableListBox;
  late final Box<Register> registerBox;
  late final Box<Invoice> invoiceBox;
  late final Box<BookingX> bookingBox;
  late final Box<SelectAttendantModel> attendantBox; // Added attendantBox

  ObjectBox._create(this.store) {
    orderBox = store.box<Orders>();
    storeXBox = store.box<StoreX>();
    tableListBox = store.box<TableList>();
    registerBox = store.box<Register>();
    invoiceBox = store.box<Invoice>();
    bookingBox = store.box<BookingX>();
    attendantBox = store.box<SelectAttendantModel>(); // Initialize attendantBox
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void close() {
    store.close();
  }
}



// import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/objectbox.g.dart';

// class ObjectBox {
//   late final Store store;

//   late final Box<Orders> orderBox;
//   late final Box<StoreX> storeXBox;
//   late final Box<TableList> tableListBox;
//   late final Box<Register> registerBox;
//   late final Box<Invoice> invoiceBox;
//   late final Box<BookingX> bookingBox;

//   ObjectBox._create(this.store) {
//     orderBox = store.box<Orders>();
//     storeXBox = store.box<StoreX>();
//     tableListBox = store.box<TableList>();
//     registerBox = store.box<Register>();
//     invoiceBox = store.box<Invoice>();
//     bookingBox = store.box<BookingX>();
//   }

//   static Future<ObjectBox> create() async {
//     final store = await openStore();
//     return ObjectBox._create(store);
//   }

//   void close() {
//     store.close();
//   }
// }
