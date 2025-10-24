import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_register_dto.freezed.dart';
part 'open_register_dto.g.dart';

@freezed
class OpenRegisterDto with _$OpenRegisterDto {
  const factory OpenRegisterDto({
    double? openingCashAtHand,
    String? note,
  }) = _OpenRegisterDto;

  factory OpenRegisterDto.fromJson(Map<String, dynamic> json) => _$OpenRegisterDtoFromJson(json);
}
