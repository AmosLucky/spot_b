import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
// Optional if Hive is used for cache store
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/navigation.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/custom_widgets.dart';

import '../api/api_client.dart';

import 'package:spotstock_inventory/objectbox.g.dart';

Dio dio = Dio();

class GeneralRepo extends ApiClient {
  Future<void> upsertBooking({
    required String trxID,
    required Map<String, dynamic> updateData,
    required UserDetails user,
  }) async {
    // Get ObjectBox booking instance
    final store = await DatabaseEngine.instance.getStore();
    final bookingBox = store.box<BookingX>();

    // Fetch the existing booking
    final existingBooking = bookingBox
        .query(BookingX_.userId
            .equals(user.id.toString())
            .and(BookingX_.trx.equals(trxID)))
        .build()
        .findFirst();

    if (existingBooking != null) {
      // Dynamically update fields if they exist in BookingX
      updateData.forEach((key, value) {
        switch (key) {
          case "room_id":
            existingBooking.roomId = value.toString();
            break;
          case "room_name":
            existingBooking.roomName = value;
            break;
          case "status":
            existingBooking.status = value;
            break;
          case "booking_option":
            existingBooking.bookingOption = value.toString();
            break;
          case "note":
            existingBooking.cancelReason = value.toString();
            break;
          case "per_night":
            existingBooking.perNight = value.toString();
            break;
          case "amount":
            existingBooking.amount = double.tryParse(value.toString()) ?? 0.0;
            existingBooking.amountPayable =
                double.tryParse(value.toString()) ?? 0.0;
            break;
          case "checkout":
            existingBooking.checkout = value.toString();
            break;
          case "checkout_time":
            existingBooking.checkoutTime = value.toString();
            break;
          case "duration":
            double duration = double.tryParse(value.toString()) ?? 0.0;
            double perNight = double.tryParse(existingBooking.perNight) ??
                0.0; // Ensure perNight is not null
            existingBooking.duration = value.toString();
            existingBooking.amount =
                (duration * perNight) + (existingBooking.amount);
            break;
          default:
            print("Ignoring unknown field: $key");
        }
      });

      // Save updated record
      bookingBox.put(existingBooking);
      print('Booking record has been updated.');
    } else {
      print('No existing booking found for trxID: $trxID');
    }
  }

  Future<Map<String, dynamic>> openFolio({
    required String module,
    required String trackID,
    required double? amountPayable,
    required Map data,
  }) async {
    UserDetails user =
        Provider.of<UserProvider>(Navigation.getContext(), listen: false).user;
    final store = await DatabaseEngine.instance.getStore();

    final folioBox = store.box<FolioX>();

    final existingFolio = folioBox
        .query(FolioX_.userId
            .equals(user.id.toString())
            .and(FolioX_.type.equals(module))
            .and(FolioX_.trackID.equals(trackID)))
        .build()
        .findFirst();

    double creditAmount = double.tryParse(data['amount'].toString()) ?? 0.0;
    double debitAmount = amountPayable ?? 0.0; // Use amountPayable for debit
    double balanceAmount = creditAmount - debitAmount; // Recalculate balance

    if (existingFolio == null) {
      // Create a new register if none exists
      folioBox.put(FolioX(
        id: 0,
        uid: trackID,
        status: false,
        customerName: data['customerName'].toString(),
        customerAddress: data['customerAddress'].toString(),
        customerPhone: '00000000',
        arrivalDate: data['arrival'],
        departureDate: data['departure'],
        balance: balanceAmount, // Updated balance
        credit: creditAmount,
        debit: debitAmount, // Debit updated
        trackID: trackID,
        userId: user.id.toString(),
        companyId: user.company!.id.toString(),
        createdAt: DateTime.now(),
        searchDate: searchDate(DateTime.now()),
        type: module,
      ));
    } else {
      // If a folio already exists, update the balance and debit
      existingFolio.debit += debitAmount;
      existingFolio.balance -= debitAmount;
      folioBox.put(existingFolio);
    }

    return {'status': true};
  }
}
