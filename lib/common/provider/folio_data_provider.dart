import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/objectbox.g.dart';

class FolioDataProvider extends ChangeNotifier {
  final Box<FolioX> folioBox;
  final Box<BookingX> bookingBox;
  List<FolioX> _data = [];
  List<FolioX> _filteredData = [];

  List<FolioX> get data => _filteredData;

  FolioDataProvider(this.folioBox, this.bookingBox) {
    fetchData();
  }

  Future<void> fetchData() async {
    _data = folioBox.getAll();
    _filteredData = List.from(_data);
    notifyListeners();
  }

  void searchData(String query) {
    if (query.isEmpty) {
      _filteredData = List.from(_data);
    } else {
      _filteredData = _data.where((folio) {
        return folio.customerName.toLowerCase().contains(query.toLowerCase()) ||
            folio.trackID.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  BookingX? getBookingForFolio(FolioX folio) {
    return bookingBox
        .query(BookingX_.trx.equals(folio.trackID))
        .build()
        .findFirst();
  }

  /// Fetch folios linked to a specific room by `roomId`
  List<FolioX> getFoliosByRoomId(String roomId) {
    return _data.where((folio) {
      final booking = getBookingForFolio(folio);
      return booking?.roomId == roomId;
    }).toList();
  }

  /// Filter folios based on a selected date range
  void filterByDateRange(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      _filteredData = List.from(_data);
    } else {
      _filteredData = _data.where((folio) {
        return folio.createdAt != null &&
            folio.createdAt!
                .isAfter(startDate.subtract(const Duration(days: 1))) &&
            folio.createdAt!.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    }
    notifyListeners();
  }

  DataTableSource getDataSource() => _FolioTableDataSource(this);
}

class _FolioTableDataSource extends DataTableSource {
  final FolioDataProvider provider;

  _FolioTableDataSource(this.provider);

  @override
  DataRow? getRow(int index) {
    if (index >= provider.data.length) return null;
    final folio = provider.data[index];
    final booking = provider.getBookingForFolio(folio);
    final formattedDate = folio.createdAt != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(folio.createdAt!)
        : "N/A";

    return DataRow(cells: [
      DataCell(Text(folio.id.toString())),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(folio.customerName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(folio.customerPhone,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 10),
              Text(folio.customerAddress,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      )),
      DataCell(Text(booking?.trx ?? "N/A")),
      DataCell(Text(booking?.roomName ?? "N/A")),
      DataCell(Text(Money.format(folio.credit),
          style: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold))),
      DataCell(Text(Money.format(folio.debit),
          style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
      DataCell(Text(Money.format(folio.balance),
          style: const TextStyle(color: Colors.orange))),
      DataCell(Text(formattedDate,
          style: const TextStyle(fontSize: 12, color: Colors.blueGrey))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => provider.data.length;

  @override
  int get selectedRowCount => 0;
}
