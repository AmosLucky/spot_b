import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/error_handling/app_error.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/textfields/spotstock_pinput.dart';
import '../view_model/spotstock_staff_pin_form_view_model.dart';

class SpotstockStaffPinForm extends StatelessWidget {
  final SpotstockStaffPinFormViewModel viewModel;
  final String staffName;
  final Function() onPinCorrect;
  final Function(AppError error) onPinIncorrect;
  const SpotstockStaffPinForm(
      {super.key,
      required this.viewModel,
      required this.staffName,
      required this.onPinCorrect,
      required this.onPinIncorrect});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              Text(
                "${SpotstockStrings.hi} $staffName,",
                style: TextStyle(
                  fontSize: SpotstockSizes.s14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                SpotstockStrings.pleaseEnterYourPinToContinue,
              ),
              const SizedBox(height: SpotstockSizes.s16),
              viewModel.verifyStaffPinCommand.running
                  ? Column(
                      children: [
                        SpotstockProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: SpotstockSizes.s8),
                        Text(
                          SpotstockStrings.verifyingPin,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SpotstockPinput(
                          controller: viewModel.pinController,
                          focusNode: viewModel.pinFocusNode,
                          validator: (pin) {
                            if (viewModel.verifyStaffPinCommand.hasFailure) {
                              return viewModel.verifyStaffPinCommand.result?.error.message;
                            }
                            return null;
                          },
                          onCompleted: (pin) async {
                            await viewModel.verifyStaffPinCommand.execute();
                            viewModel.verifyStaffPinCommand.result?.when(
                              onSuccess: (success) {
                                onPinCorrect();
                              },
                              onFailure: (error) {
                                onPinIncorrect(error);
                              },
                            );
                          },
                        ),
                      ],
                    ),
              const SizedBox(height: SpotstockSizes.s16),
            ],
          ),
        );
      },
    );
  }
}
