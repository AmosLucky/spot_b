import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:spotstock_inventory/core/presentation/extensions/num_extensions.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/error_handling/app_error.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/shared/result.dart';
import '../../../pos/data/enums/enums.dart';
import '../../../pos/data/models/sale.dart';
import '../models/extra_receipt_details.dart';
import '../../domain/services/sale_receipt_service.dart';

class PdfSaleReceiptService implements SaleReceiptService {
  @override
  Future<pw.Document> generateReceipt(Sale sale, {ExtraReceiptDetails? extraReceiptDetails}) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: extraReceiptDetails?.receiptFormat ??
            PdfPageFormat(SpotstockSizes.s57 * PdfPageFormat.mm, double.infinity),
        margin: const pw.EdgeInsets.all(SpotstockSizes.s8),
        build: (context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text(
                  extraReceiptDetails?.companyName ?? SpotstockStrings.na,
                  style: pw.TextStyle(
                    fontSize: SpotstockSizes.s12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  extraReceiptDetails?.companyAddress ?? SpotstockStrings.na,
                  style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  "${SpotstockStrings.tel}: ${extraReceiptDetails?.companyPhone ?? SpotstockStrings.na} | ${SpotstockStrings.email}: ${extraReceiptDetails?.companyEmail ?? SpotstockStrings.na}",
                  style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Divider(
                thickness: SpotstockSizes.s0_5,
                color: PdfColors.black,
                height: SpotstockSizes.s2,
              ),
              pw.SizedBox(height: SpotstockSizes.s1),
              pw.Text(
                SpotstockStrings.salesReceiptCapital,
                style: pw.TextStyle(
                  fontSize: SpotstockSizes.s12,
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                '${SpotstockStrings.branch}: ${sale.warehouseName ?? SpotstockStrings.na}',
                style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                '${SpotstockStrings.customer}: ${sale.customerName ?? SpotstockStrings.na}',
                style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                '${SpotstockStrings.cashier}: ${sale.staffName ?? SpotstockStrings.na}',
                style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                '${SpotstockStrings.receiptNo}: ${sale.referenceCode ?? SpotstockStrings.na}',
                style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                '${SpotstockStrings.date}: ${sale.date?.toFormattedDateTime() ?? SpotstockStrings.na}',
                style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                textAlign: pw.TextAlign.center,
              ),
              pw.Divider(
                thickness: SpotstockSizes.s0_5,
                color: PdfColors.black,
                height: SpotstockSizes.s2,
              ),
              pw.Table(
                columnWidths: {
                  0: const pw.FlexColumnWidth(SpotstockSizes.s5),
                  1: const pw.FlexColumnWidth(SpotstockSizes.s2),
                  2: const pw.FlexColumnWidth(SpotstockSizes.s1),
                  3: const pw.FlexColumnWidth(SpotstockSizes.s2_8),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(
                        SpotstockStrings.item,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        SpotstockStrings.price,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        SpotstockStrings.qty,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        SpotstockStrings.amount,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Divider(
                        thickness: SpotstockSizes.s0_5,
                        color: PdfColors.black,
                        height: SpotstockSizes.s2,
                      ),
                      pw.Divider(
                        thickness: SpotstockSizes.s0_5,
                        color: PdfColors.black,
                        height: SpotstockSizes.s2,
                      ),
                      pw.Divider(
                        thickness: SpotstockSizes.s0_5,
                        color: PdfColors.black,
                        height: SpotstockSizes.s2,
                      ),
                      pw.Divider(
                        thickness: SpotstockSizes.s0_5,
                        color: PdfColors.black,
                        height: SpotstockSizes.s2,
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.SizedBox(height: SpotstockSizes.s4),
                      pw.SizedBox(height: SpotstockSizes.s4),
                      pw.SizedBox(height: SpotstockSizes.s4),
                      pw.SizedBox(height: SpotstockSizes.s4),
                    ],
                  ),
                  ...(sale.saleItems?.expand((item) {
                        final total = ((item.productPrice ?? 0) * (item.quantity ?? 0)).toMoney();
                        return [
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.only(right: SpotstockSizes.s2),
                                child: pw.Text(item.productName ?? SpotstockStrings.na,
                                    style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                              ),
                              pw.Text(item.productPrice?.toMoney() ?? SpotstockStrings.na,
                                  style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                              pw.Text(item.quantity?.toInt().toString() ?? SpotstockStrings.na,
                                  textAlign: pw.TextAlign.center,
                                  style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                              pw.Text(total,
                                  textAlign: pw.TextAlign.right,
                                  style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                            ],
                          ),
                        ];
                      }).toList() ??
                      [])
                ],
              ),
              pw.Divider(
                thickness: SpotstockSizes.s0_5,
                color: PdfColors.black,
                height: SpotstockSizes.s2,
              ),
              pw.Table(
                columnWidths: {
                  0: pw.FlexColumnWidth(SpotstockSizes.s1),
                  1: pw.FlexColumnWidth(SpotstockSizes.s1),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('${SpotstockStrings.vat} (${sale.taxRate ?? SpotstockStrings.na}%):',
                          style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                      pw.Text(
                        sale.taxAmount?.toMoney() ?? SpotstockStrings.na,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                        ),
                      ),
                    ],
                  ),
                  if (sale.paymentStatus != PaymentStatus.unpaid)
                    pw.TableRow(
                      children: [
                        pw.Text(
                          SpotstockStrings.payments,
                          style: pw.TextStyle(
                            fontSize: SpotstockSizes.s8,
                          ),
                        ),
                      ],
                    ),
                  ...(sale.payments?.map((payment) {
                        return pw.TableRow(
                          children: [
                            pw.Text(
                                " ${payment.paymentType?.name.toUpperCase() ?? SpotstockStrings.na}",
                                style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                            pw.Text(payment.amount?.toMoney() ?? SpotstockStrings.na,
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                          ],
                        );
                      }).toList() ??
                      []),
                  pw.TableRow(
                    children: [
                      pw.Divider(
                        thickness: SpotstockSizes.s0_5,
                        color: PdfColors.black,
                        height: SpotstockSizes.s2,
                      ),
                      pw.Divider(
                        thickness: SpotstockSizes.s0_5,
                        color: PdfColors.black,
                        height: SpotstockSizes.s2,
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('${SpotstockStrings.discount}:',
                          style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                      pw.Text(
                        sale.discount?.toMoney() ?? SpotstockStrings.na,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('${SpotstockStrings.shipping}:',
                          style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                      pw.Text(
                        sale.shipping?.toMoney() ?? SpotstockStrings.na,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        SpotstockStrings.paymentStatus,
                        style: pw.TextStyle(fontSize: SpotstockSizes.s8),
                      ),
                      pw.Text(
                        sale.paymentStatus?.name.toUpperCase() ?? SpotstockStrings.na,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('${SpotstockStrings.amountReceived}:',
                          style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                      pw.Text(
                        sale.receivedAmount?.toMoney() ?? SpotstockStrings.na,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('${SpotstockStrings.amountOwed}:',
                          style: pw.TextStyle(fontSize: SpotstockSizes.s8)),
                      pw.Text(
                        sale.dueAmount?.toMoney() ?? SpotstockStrings.na,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s8,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text(
                        '${SpotstockStrings.grandTotal}:',
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "${SpotstockStrings.ngn} ${sale.grandTotal?.toMoney() ?? SpotstockStrings.na}",
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: SpotstockSizes.s10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: SpotstockSizes.s10),
              pw.Center(
                child: pw.Text(
                  SpotstockStrings.thankYouForYourPurchaseExclamation,
                  style: pw.TextStyle(fontSize: SpotstockSizes.s10, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  SpotstockStrings.pleaseKeepThisReceiptForYourRecords,
                  style: pw.TextStyle(fontSize: SpotstockSizes.s8, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Center(
                child: pw.Text(
                  "${SpotstockStrings.ref}: ${sale.referenceCode ?? SpotstockStrings.na}",
                  style: pw.TextStyle(fontSize: SpotstockSizes.s8, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  @override
  Future<Result> printReceipt(Sale sale, {ExtraReceiptDetails? extraReceiptDetails}) async {
    final pdf = await generateReceipt(sale, extraReceiptDetails: extraReceiptDetails);
    try {
      await Printing.layoutPdf(onLayout: (format) => pdf.save());
      return Result.success(null);
    } catch (e) {
      return Result.failure(AppError(message: e.toString()));
    }
  }

  @override
  Future<Result> shareReceipt(Sale sale, {ExtraReceiptDetails? extraReceiptDetails}) async {
    final pdf = await generateReceipt(sale, extraReceiptDetails: extraReceiptDetails);
    try {
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename:
            '${sale.referenceCode}_${extraReceiptDetails?.companyName ?? SpotstockStrings.na}_receipt.pdf',
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(AppError(message: e.toString()));
    }
  }
}
