import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  @JsonValue(1)
  paid,
  @JsonValue(2)
  unpaid,
  @JsonValue(3)
  partial,
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
