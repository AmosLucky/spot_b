import 'package:freezed_annotation/freezed_annotation.dart';

import 'hold.dart';

part 'grouped_hold.freezed.dart';

@freezed
class GroupedHold with _$GroupedHold {
  const factory GroupedHold({
    required List<Hold> holds,
  }) = _GroupedHold;

  const GroupedHold._();

  Hold? get _firstOrNull => holds.isNotEmpty ? holds.first : null;
  Hold? get firstOrNull => _firstOrNull;

  int get holdCount => holds.length;

  int get totalHoldItemsCount => holds.fold<int>(0, (total, hold) => total + (hold.holdItems?.length ?? 0));

  String? get tableName => _firstOrNull?.tableName?.toString();

  String? get customerName => _firstOrNull?.customerName;

  String? get attendantName {
    final att = _firstOrNull?.attendant;
    if (att == null) return null;

    final first = att.firstName ?? "";
    final last = att.lastName ?? "";
    final full = "$first $last".trim();

    return full.isEmpty ? null : full;
  }

  String? get warehouseName => _firstOrNull?.warehouseName;

  double get grandTotal => holds.fold(0.0, (total, hold) => total + (hold.grandTotal ?? 0.0));

  DateTime? get date => _firstOrNull?.date;

  String? get groupedHoldReferenceNo {
    if (holds.isEmpty) return null;

    final refCodes = holds.map((h) => h.referenceCode).whereType<String>().toList();

    if (refCodes.isEmpty) return null;

    final firstRef = refCodes.first;

    final suffixes = refCodes.skip(1).map((ref) {
      if (ref.length <= 4) return ref;
      return ref.substring(ref.length - 4);
    });

    return ([firstRef] + suffixes.toList()).join("-");
  }

  bool? get hasUnsyncedHold {
    for (final hold in holds) {
      if (hold.isSynced == false) {
        return true;
      }
    }
    return false;
  }
}
