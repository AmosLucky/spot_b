// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_warehouse.freezed.dart';
part 'product_warehouse.g.dart';

@freezed
class ProductWarehouse with _$ProductWarehouse {
  const factory ProductWarehouse({
    @JsonKey(name: 'total_quantity') int? totalQuantity,
    String? name,
  }) = _ProductWarehouse;

  factory ProductWarehouse.fromJson(Map<String, dynamic> json) => _$ProductWarehouseFromJson(json);
}
