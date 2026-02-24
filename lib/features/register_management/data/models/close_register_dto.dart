// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'close_register_dto.freezed.dart';
part 'close_register_dto.g.dart';

@freezed
class CloseRegisterDto with _$CloseRegisterDto {
  const factory CloseRegisterDto({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'cash_in_hand_while_closing') double? cashInHandWhileClosing,
    @JsonKey(name: 'notes') String? notes,
  }) = _CloseRegisterDto;

  factory CloseRegisterDto.fromJson(Map<String, dynamic> json) => _$CloseRegisterDtoFromJson(json);
}
