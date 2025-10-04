// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bar_table.freezed.dart';

@freezed
class BarTable with _$BarTable {
  const factory BarTable({
    int? id,
    String? name,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'chairs_no') int? chairsNo,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    required String link,
  }) = _BarTable;

  factory BarTable.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    final links = json['links'] as Map<String, dynamic>;

    return BarTable(
      id: int.parse(json['id'].toString()),
      name: attributes['name'] as String,
      companyId: attributes['company_id'] as int,
      chairsNo: attributes['chairs_no'] as int,
      createdAt: DateTime.parse(attributes['created_at'] as String),
      link: links['self'] as String,
    );
  }
}
