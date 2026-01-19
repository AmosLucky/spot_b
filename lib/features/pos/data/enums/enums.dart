import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';

enum PaymentStatus {
  @JsonValue(1)
  paid,
  @JsonValue(2)
  unpaid,
  @JsonValue(3)
  partial,
}

extension PaymentStatusX on PaymentStatus {
  int get toInt {
    switch (this) {
      case PaymentStatus.paid:
        return 1;
      case PaymentStatus.unpaid:
        return 2;
      case PaymentStatus.partial:
        return 3;
    }
  }

  static PaymentStatus fromInt(int value) {
    switch (value) {
      case 1:
        return PaymentStatus.paid;
      case 2:
        return PaymentStatus.unpaid;
      case 3:
        return PaymentStatus.partial;
      default:
        throw ArgumentError('${SpotstockStrings.invalidPaymentStatus}: $value');
    }
  }
}

enum SaleStatus {
  @JsonValue(1)
  completed,
  @JsonValue(2)
  held,
  @JsonValue(3)
  cancelled,
}

enum PaymentType {
  @JsonValue(1)
  cash,
  @JsonValue(2)
  pos,
  @JsonValue(3)
  transfer,
  @JsonValue(4)
  folio,
  @JsonValue(5)
  other,
}

extension PaymentTypeX on PaymentType {
  int get toInt {
    switch (this) {
      case PaymentType.cash:
        return 1;
      case PaymentType.pos:
        return 2;
      case PaymentType.transfer:
        return 3;
      case PaymentType.folio:
        return 4;
      case PaymentType.other:
        return 5;
    }
  }

  static PaymentType fromInt(int value) {
    switch (value) {
      case 1:
        return PaymentType.cash;
      case 2:
        return PaymentType.pos;
      case 3:
        return PaymentType.transfer;
      case 4:
        return PaymentType.folio;
      case 5:
        return PaymentType.other;
      default:
        throw ArgumentError('${SpotstockStrings.invalidPaymentType}: $value');
    }
  }
}
