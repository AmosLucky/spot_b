// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockImpl _$$StockImplFromJson(Map<String, dynamic> json) => _$StockImpl(
      id: (json['id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$StockImplToJson(_$StockImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'warehouse_id': instance.warehouseId,
    };
