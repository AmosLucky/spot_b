import 'package:freezed_annotation/freezed_annotation.dart';

part 'spotstock_api_data_item.freezed.dart';
part 'spotstock_api_data_item.g.dart';

@freezed
class SpotstockApiDataItem with _$SpotstockApiDataItem {
  const factory SpotstockApiDataItem({
    int? id,
    String? type,
    Map<String, dynamic>? attributes,
    Map<String, dynamic>? links,
  }) = _SpotstockApiDataItem;

  factory SpotstockApiDataItem.fromJson(Map<String, dynamic> json) =>
      _$SpotstockApiDataItemFromJson(json);
}
