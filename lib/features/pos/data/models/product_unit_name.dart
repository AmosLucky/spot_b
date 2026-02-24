import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_unit_name.freezed.dart';
part 'product_unit_name.g.dart';

@freezed
class ProductUnitName with _$ProductUnitName {
  const factory ProductUnitName({
    int? id,
    String? name,
  }) = _ProductUnitName;

  factory ProductUnitName.fromJson(Map<String, dynamic> json) => _$ProductUnitNameFromJson(json);
}
