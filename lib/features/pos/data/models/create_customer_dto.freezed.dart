// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_customer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateCustomerDto _$CreateCustomerDtoFromJson(Map<String, dynamic> json) {
  return _CreateCustomerDto.fromJson(json);
}

/// @nodoc
mixin _$CreateCustomerDto {
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this CreateCustomerDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCustomerDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCustomerDtoCopyWith<CreateCustomerDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCustomerDtoCopyWith<$Res> {
  factory $CreateCustomerDtoCopyWith(
          CreateCustomerDto value, $Res Function(CreateCustomerDto) then) =
      _$CreateCustomerDtoCopyWithImpl<$Res, CreateCustomerDto>;
  @useResult
  $Res call(
      {String? address,
      String? city,
      String? email,
      String? country,
      String? name,
      String? phone});
}

/// @nodoc
class _$CreateCustomerDtoCopyWithImpl<$Res, $Val extends CreateCustomerDto>
    implements $CreateCustomerDtoCopyWith<$Res> {
  _$CreateCustomerDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCustomerDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? city = freezed,
    Object? email = freezed,
    Object? country = freezed,
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateCustomerDtoImplCopyWith<$Res>
    implements $CreateCustomerDtoCopyWith<$Res> {
  factory _$$CreateCustomerDtoImplCopyWith(_$CreateCustomerDtoImpl value,
          $Res Function(_$CreateCustomerDtoImpl) then) =
      __$$CreateCustomerDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? address,
      String? city,
      String? email,
      String? country,
      String? name,
      String? phone});
}

/// @nodoc
class __$$CreateCustomerDtoImplCopyWithImpl<$Res>
    extends _$CreateCustomerDtoCopyWithImpl<$Res, _$CreateCustomerDtoImpl>
    implements _$$CreateCustomerDtoImplCopyWith<$Res> {
  __$$CreateCustomerDtoImplCopyWithImpl(_$CreateCustomerDtoImpl _value,
      $Res Function(_$CreateCustomerDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCustomerDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? city = freezed,
    Object? email = freezed,
    Object? country = freezed,
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(_$CreateCustomerDtoImpl(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCustomerDtoImpl implements _CreateCustomerDto {
  const _$CreateCustomerDtoImpl(
      {this.address,
      this.city,
      this.email,
      this.country,
      this.name,
      this.phone});

  factory _$CreateCustomerDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateCustomerDtoImplFromJson(json);

  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? email;
  @override
  final String? country;
  @override
  final String? name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'CreateCustomerDto(address: $address, city: $city, email: $email, country: $country, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCustomerDtoImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, city, email, country, name, phone);

  /// Create a copy of CreateCustomerDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCustomerDtoImplCopyWith<_$CreateCustomerDtoImpl> get copyWith =>
      __$$CreateCustomerDtoImplCopyWithImpl<_$CreateCustomerDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCustomerDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateCustomerDto implements CreateCustomerDto {
  const factory _CreateCustomerDto(
      {final String? address,
      final String? city,
      final String? email,
      final String? country,
      final String? name,
      final String? phone}) = _$CreateCustomerDtoImpl;

  factory _CreateCustomerDto.fromJson(Map<String, dynamic> json) =
      _$CreateCustomerDtoImpl.fromJson;

  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get email;
  @override
  String? get country;
  @override
  String? get name;
  @override
  String? get phone;

  /// Create a copy of CreateCustomerDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCustomerDtoImplCopyWith<_$CreateCustomerDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
