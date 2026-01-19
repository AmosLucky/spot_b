import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_customer_dto.freezed.dart';
part 'create_customer_dto.g.dart';

@freezed
class CreateCustomerDto with _$CreateCustomerDto {
  const factory CreateCustomerDto({
    String? address,
    String? city,
    String? email,
    String? country,
    String? name,
    String? phone,
  }) = _CreateCustomerDto;

  factory CreateCustomerDto.fromJson(Map<String, dynamic> json) => _$CreateCustomerDtoFromJson(json);
}
