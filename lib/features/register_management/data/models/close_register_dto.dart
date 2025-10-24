import 'package:freezed_annotation/freezed_annotation.dart';

part 'close_register_dto.freezed.dart';
part 'close_register_dto.g.dart';

@freezed
class CloseRegisterDto with _$CloseRegisterDto {
  const factory CloseRegisterDto({
    required int id,
    required double closingCashAtHand,
    bool? closeCurrentRegister,
  }) = _CloseRegisterDto;

  factory CloseRegisterDto.fromJson(Map<String, dynamic> json) => _$CloseRegisterDtoFromJson(json);
}
