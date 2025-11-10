// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pdf/pdf.dart';

part 'extra_receipt_details.freezed.dart';
part 'extra_receipt_details.g.dart';

@freezed
class ExtraReceiptDetails with _$ExtraReceiptDetails {
  const factory ExtraReceiptDetails({
    @JsonKey(includeFromJson: false, includeToJson: false) PdfPageFormat? receiptFormat,
    String? tableName,
    String? companyName,
    String? companyAddress,
    String? companyPhone,
    String? companyEmail,
  }) = _ExtraReceiptDetails;

  factory ExtraReceiptDetails.fromJson(Map<String, dynamic> json) =>
      _$ExtraReceiptDetailsFromJson(json);
}
