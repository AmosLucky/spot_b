import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar.dart';
import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../register_management/data/models/close_register_dto.dart';
import '../../../register_management/domain/usecases/close_register.dart';

class SpotstockCloseRegisterFormViewModel extends SpotstockFormViewModel with SpotstockSnackbarMixin {
  final CloseRegister closeRegister;
  SpotstockCloseRegisterFormViewModel(this.closeRegister);

  final TextEditingController _cashAtHandController = TextEditingController();
  TextEditingController get cashAtHandController => _cashAtHandController;

  final TextEditingController _noteController = TextEditingController();
  TextEditingController get noteController => _noteController;

  final FocusNode _cashAtHandFocusNode = FocusNode();
  FocusNode get cashAtHandFocusNode => _cashAtHandFocusNode;

  late Command1<void, BuildContext> closeRegisterCommand;

  late Command1<void, BuildContext> requestFocusCommand;

  VoidCallback? _onRegisterClosed;
  VoidCallback get onRegisterClosed => _onRegisterClosed!;

  @override
  void bind(BuildContext context, {VoidCallback? onRegisterClosed}) {
    closeRegisterCommand = Command1<void, BuildContext>(_closeRegister);
    requestFocusCommand = Command1<void, BuildContext>(_requestFocus);
    _onRegisterClosed = onRegisterClosed ?? () {};
  }

  Future<Result<void>> _requestFocus(BuildContext context) async {
    FocusScope.of(context).requestFocus(_cashAtHandFocusNode);
    return Result.success(null);
  }

  Future<Result<void>> _closeRegister(BuildContext context) async {
    final closeRegisterDto = CloseRegisterDto(
      cashInHandWhileClosing: double.parse(cashAtHandController.text),
      notes: noteController.text,
    );
    final result = await closeRegister(closeRegisterDto);
    result.when(
      onSuccess: (value) {
        SpotstockNavigation.goBack();
        onRegisterClosed();
        return Result.success(null);
      },
      onFailure: (error) {
        if (error.code == SpotstockStatusCode.unprocessableEntity.toString()) {
          SpotstockNavigation.goBack();
          SpotstockNavigation.goBack(true);
          showErrorSnackbar(error, title: SpotstockStrings.anErrorOccurred);
        }
        addError(error);
      },
    );
    return result;
  }

  @override
  void dispose() {
    _cashAtHandController.dispose();
    _noteController.dispose();
    _cashAtHandFocusNode.dispose();
    super.dispose();
  }
}
