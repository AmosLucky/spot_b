import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/verify_pin_dto.dart';
import '../../domain/usecases/verify_staff_pin.dart';

class SpotstockStaffPinFormViewModel extends SpotstockFormViewModel {
  final VerifyStaffPin verifyStaffPin;

  SpotstockStaffPinFormViewModel(this.verifyStaffPin);

  VerifyPinDto _verifyPinDto = VerifyPinDto(pin: SpotstockStrings.EMPTY, userId: 0);
  VerifyPinDto get verifyPinDto => _verifyPinDto;

  final TextEditingController _pinController = TextEditingController();
  TextEditingController get pinController => _pinController;
  final FocusNode _pinFocusNode = FocusNode();
  FocusNode get pinFocusNode => _pinFocusNode;

  late Command0<void> _verifyStaffPinCommand;
  Command0<void> get verifyStaffPinCommand => _verifyStaffPinCommand;

  @override
  void bind(
    BuildContext context, {
    int? userId,
  }) {
    _verifyPinDto = VerifyPinDto(pin: SpotstockStrings.EMPTY, userId: userId ?? 0);
    _pinFocusNode.requestFocus();
    _verifyStaffPinCommand = Command0<void>(_verifyStaffPin)
      ..addListener(() {
        notifyListeners();
      });
  }

  Future<Result<void>> _verifyStaffPin() async {
    final result = await verifyStaffPin(_verifyPinDto.copyWith(pin: _pinController.text));
    result.when(
      onSuccess: (success) {
        SpotstockNavigation.goBack();
      },
      onFailure: (error) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          formKey.currentState?.validate();
        });
        notifyListeners();
      },
    );
    return result;
  }
}
