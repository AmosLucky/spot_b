import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/data/models/spotstock_user.dart';

part 'register.freezed.dart';

@freezed
class Register with _$Register {
  const factory Register({
    int? id,
    DateTime? createdAt,
    DateTime? closedAt,
    bool? isClosed,
    double? openingCashAtHand,
    double? closingCashAtHand,
    SpotstockUser? user,
    String? note,
    bool? isSynced,
  }) = _Register;

  factory Register.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>?;

    return Register(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      createdAt: attributes?['created_at'] != null ? DateTime.tryParse(attributes!['created_at']) : null,
      closedAt: attributes?['closed_at'] != null ? DateTime.tryParse(attributes!['closed_at']) : null,
      isClosed: attributes?['closed_at'] != null ? true : false,
      openingCashAtHand: attributes?['cash_in_hand'] != null ? double.tryParse(attributes!['cash_in_hand'].toString()) : null,
      closingCashAtHand: attributes?['cash_in_hand_while_closing'] != null
          ? double.tryParse(
              attributes!['cash_in_hand_while_closing'].toString(),
            )
          : null,
      user: attributes?['user'] != null
          ? SpotstockUser.fromJson(
              attributes!['user'] as Map<String, dynamic>,
            )
          : null,
      note: attributes?['notes'] as String?,
    );
  }
}
