import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_table.freezed.dart';
part 'bar_table.g.dart';

@freezed
class BarTable with _$BarTable {
  const factory BarTable({
    int? id,
  }) = _BarTable;

  factory BarTable.fromJson(Map<String, dynamic> json) => _$BarTableFromJson(json);
}
