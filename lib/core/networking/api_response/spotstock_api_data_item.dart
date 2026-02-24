import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotstock_inventory/core/constants/strings/spotstock_strings.dart';

part 'spotstock_api_data_item.freezed.dart';
part 'spotstock_api_data_item.g.dart';

class FlexibleLinksConverter implements JsonConverter<Map<String, dynamic>?, Object?> {
  const FlexibleLinksConverter();

  @override
  Map<String, dynamic>? fromJson(Object? json) {
    if (json == null) return null;

    if (json is Map<String, dynamic>) {
      return json;
    }

    if (json is List) {
      return {
        for (var i = 0; i < json.length; i++) i.toString(): json[i],
      };
    }

    throw ArgumentError('${SpotstockStrings.invalidTypeForLinksColon} ${json.runtimeType}');
  }

  @override
  Object? toJson(Map<String, dynamic>? object) => object;
}

@freezed
class SpotstockApiDataItem with _$SpotstockApiDataItem {
  const factory SpotstockApiDataItem({
    int? id,
    String? type,
    Map<String, dynamic>? attributes,
    @FlexibleLinksConverter() Map<String, dynamic>? links,
  }) = _SpotstockApiDataItem;

  factory SpotstockApiDataItem.fromJson(Map<String, dynamic> json) => _$SpotstockApiDataItemFromJson(json);
}
