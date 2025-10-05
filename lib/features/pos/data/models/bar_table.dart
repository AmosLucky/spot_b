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
    String? link,
  }) = _BarTable;

  factory BarTable.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final links = json['links'];

    return BarTable(
      id: int.tryParse(json['id'].toString()),
      name: attributes['name'],
      companyId: attributes['company_id'],
      chairsNo: attributes['chairs_no'],
      createdAt:
          attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
      link: links['self'],
    );
  }
}
