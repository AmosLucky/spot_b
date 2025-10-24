import 'package:freezed_annotation/freezed_annotation.dart';

part 'register.freezed.dart';
part 'register.g.dart';

@freezed
class Register with _$Register {
  const factory Register({
    int? id,
    DateTime? createdAt,
    bool? isOpen,
    bool? isValid,
    double? openingCashAtHand,
    double? closingCashAtHand,
  }) = _Register;

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);
}
