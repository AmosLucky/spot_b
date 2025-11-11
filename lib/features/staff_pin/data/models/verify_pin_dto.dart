// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_pin_dto.freezed.dart';
part 'verify_pin_dto.g.dart';

@freezed
class VerifyPinDto with _$VerifyPinDto {
  const factory VerifyPinDto({
    required String pin,
    @JsonKey(name: 'user_id') required int userId,
  }) = _VerifyPinDto;

  factory VerifyPinDto.fromJson(Map<String, dynamic> json) => _$VerifyPinDtoFromJson(json);
}
