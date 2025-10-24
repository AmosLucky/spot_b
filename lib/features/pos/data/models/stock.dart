// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

@freezed
class Stock with _$Stock {
  const factory Stock({
    int? id,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
  }) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}
