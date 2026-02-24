import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/symbols/naira_symbol.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../data/enums/enums.dart';
import '../../data/models/create_sale_dto.dart';
import '../view_model/spotstock_payment_form_view_model.dart';

const int maxNoteLines = 3;

class SpotstockPaymentForm extends StatelessWidget {
  final SpotstockPaymentFormViewModel viewModel;
  final Function(PaymentStatus) onPaymentStatusChanged;
  final Function(String?) onNoteChanged;
  final Function(List<PaymentDto>) onPaymentTypeUpdated;
  final Function(String?) onCashAmountChanged;
  final Function(String?) onPosAmountChanged;
  final Function(String?) onTransferAmountChanged;
  final Function(String?) onFolioAmountChanged;
  final Function(String?) onOtherAmountChanged;
  const SpotstockPaymentForm({
    super.key,
    required this.viewModel,
    required this.onPaymentStatusChanged,
    required this.onNoteChanged,
    required this.onPaymentTypeUpdated,
    required this.onCashAmountChanged,
    required this.onPosAmountChanged,
    required this.onTransferAmountChanged,
    required this.onFolioAmountChanged,
    required this.onOtherAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(SpotstockStrings.payingAmount),
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockTextField(
                enabled: false,
                controller: viewModel.payingAmountController,
                hintText: SpotstockStrings.zero_00,
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.change),
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockTextField(
                enabled: false,
                controller: viewModel.changeController,
                hintText: SpotstockStrings.zero_00,
              ),
              const SizedBox(height: SpotstockSizes.s10),
              if (!viewModel.isUnpaid) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(SpotstockStrings.paymentType),
                    const SizedBox(height: SpotstockSizes.s8),
                    SegmentedButton<PaymentType>(
                      multiSelectionEnabled: true,
                      showSelectedIcon: false,
                      selected: viewModel.selectedPaymentTypes,
                      segments: [
                        ButtonSegment(
                          value: PaymentType.cash,
                          label: Text(
                            SpotstockStrings.cash,
                            style: TextStyle(fontSize: SpotstockSizes.s11),
                          ),
                        ),
                        ButtonSegment(
                          value: PaymentType.pos,
                          label: Text(
                            SpotstockStrings.pos,
                            style: TextStyle(fontSize: SpotstockSizes.s11),
                          ),
                        ),
                        ButtonSegment(
                          value: PaymentType.transfer,
                          label: Text(
                            SpotstockStrings.transfer,
                            style: TextStyle(fontSize: SpotstockSizes.s11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ButtonSegment(
                          enabled: false,
                          value: PaymentType.folio,
                          label: Text(
                            SpotstockStrings.folio,
                            style: TextStyle(fontSize: SpotstockSizes.s11),
                          ),
                        ),
                        ButtonSegment(
                          value: PaymentType.other,
                          label: Text(
                            SpotstockStrings.other,
                            style: TextStyle(fontSize: SpotstockSizes.s11),
                          ),
                        ),
                      ],
                      onSelectionChanged: (value) {
                        final payments = viewModel.onPaymentTypeUpdated(value);
                        onPaymentTypeUpdated(payments);
                      },
                    ),
                    if (viewModel.isPaymentTypeSelected(PaymentType.cash)) ...[
                      const SizedBox(height: SpotstockSizes.s10),
                      Text(SpotstockStrings.cashAmount),
                      const SizedBox(height: SpotstockSizes.s8),
                      SpotstockTextField(
                        controller: viewModel.cashAmountController,
                        hintText: SpotstockStrings.zero_00,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          onCashAmountChanged(value);
                        },
                      ),
                    ],
                    if (viewModel.isPaymentTypeSelected(PaymentType.pos)) ...[
                      const SizedBox(height: SpotstockSizes.s10),
                      Text(SpotstockStrings.posAmount),
                      const SizedBox(height: SpotstockSizes.s8),
                      SpotstockTextField(
                        controller: viewModel.posAmountController,
                        hintText: SpotstockStrings.zero_00,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          onPosAmountChanged(value);
                        },
                      ),
                    ],
                    if (viewModel.isPaymentTypeSelected(PaymentType.transfer)) ...[
                      const SizedBox(height: SpotstockSizes.s10),
                      Text(SpotstockStrings.transferAmount),
                      const SizedBox(height: SpotstockSizes.s8),
                      SpotstockTextField(
                        controller: viewModel.transferAmountController,
                        hintText: SpotstockStrings.zero_00,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          onTransferAmountChanged(value);
                        },
                      ),
                    ],
                    if (viewModel.isPaymentTypeSelected(PaymentType.folio)) ...[
                      const SizedBox(height: SpotstockSizes.s10),
                      Text(SpotstockStrings.folioAmount),
                      const SizedBox(height: SpotstockSizes.s8),
                      SpotstockTextField(
                        controller: viewModel.folioAmountController,
                        hintText: SpotstockStrings.zero_00,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          onFolioAmountChanged(value);
                        },
                      ),
                    ],
                    if (viewModel.isPaymentTypeSelected(PaymentType.other)) ...[
                      const SizedBox(height: SpotstockSizes.s10),
                      Text(SpotstockStrings.otherAmount),
                      const SizedBox(height: SpotstockSizes.s8),
                      SpotstockTextField(
                        controller: viewModel.otherAmountController,
                        hintText: SpotstockStrings.zero_00,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          onOtherAmountChanged(value);
                        },
                      ),
                    ],
                  ],
                ),
              ],
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.paymentStatus),
              const SizedBox(height: SpotstockSizes.s8),
              SegmentedButton<PaymentStatus>(
                selected: {viewModel.selectedPaymentStatus},
                onSelectionChanged: (value) {
                  viewModel.onPaymentStatusChanged(value.first);
                  onPaymentStatusChanged(value.first);
                },
                segments: [
                  ButtonSegment(
                    value: PaymentStatus.paid,
                    label: Text(SpotstockStrings.paid),
                  ),
                  ButtonSegment(
                    value: PaymentStatus.unpaid,
                    label: Text(SpotstockStrings.unpaid),
                  ),
                  ButtonSegment(
                    value: PaymentStatus.partial,
                    label: Text(SpotstockStrings.partial),
                  ),
                ],
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.note),
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockTextField(
                maxLines: maxNoteLines,
                controller: viewModel.noteController,
                onChanged: (value) => onNoteChanged(value),
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.summary),
              const SizedBox(height: SpotstockSizes.s8),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SpotstockSizes.s10,
                  vertical: SpotstockSizes.s16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(SpotstockSizes.s10),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.totalProducts,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(SpotstockSizes.s8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            viewModel.totalProductCount.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.totalAmount,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            NairaSymbol(
                              size: SpotstockSizes.s12,
                            ),
                            Text(viewModel.totalAmount.toMoney()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.orderVat,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            NairaSymbol(
                              size: SpotstockSizes.s12,
                            ),
                            Text(viewModel.vat.toMoney()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.discount,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            NairaSymbol(
                              size: SpotstockSizes.s12,
                            ),
                            Text(viewModel.discount.toMoney()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.shipping,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            NairaSymbol(
                              size: SpotstockSizes.s12,
                            ),
                            Text(viewModel.shipping.toMoney()),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.staff,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(viewModel.staffName ?? ''),
                      ],
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Divider(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      height: SpotstockSizes.s1,
                    ),
                    const SizedBox(height: SpotstockSizes.s8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SpotstockStrings.grandTotal,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            NairaSymbol(
                              size: SpotstockSizes.s12,
                            ),
                            Text(viewModel.grandTotal.toMoney()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
