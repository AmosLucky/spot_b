// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_register_dto.freezed.dart';
part 'open_register_dto.g.dart';

@freezed
class OpenRegisterDto with _$OpenRegisterDto {
  const factory OpenRegisterDto({
    @JsonKey(name: 'cash_in_hand') double? openingCashAtHand,
    @JsonKey(name: 'notes') String? note,
  }) = _OpenRegisterDto;

  factory OpenRegisterDto.fromJson(Map<String, dynamic> json) => _$OpenRegisterDtoFromJson(json);
}
