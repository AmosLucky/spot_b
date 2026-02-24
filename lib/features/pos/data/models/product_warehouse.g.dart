// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_warehouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductWarehouseImpl _$$ProductWarehouseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductWarehouseImpl(
      totalQuantity: (json['total_quantity'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$ProductWarehouseImplToJson(
        _$ProductWarehouseImpl instance) =>
    <String, dynamic>{
      'total_quantity': instance.totalQuantity,
      'name': instance.name,
    };
