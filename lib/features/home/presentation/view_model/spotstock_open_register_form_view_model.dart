import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../register_management/data/models/open_register_dto.dart';
import '../../../register_management/domain/usecases/open_register.dart';

class SpotstockOpenRegisterFormViewModel extends SpotstockFormViewModel {
  final OpenRegister openRegister;
  SpotstockOpenRegisterFormViewModel(this.openRegister);

  final TextEditingController _cashAtHandController = TextEditingController();
  TextEditingController get cashAtHandController => _cashAtHandController;

  final TextEditingController _noteController = TextEditingController();
  TextEditingController get noteController => _noteController;

  final FocusNode _cashAtHandFocusNode = FocusNode();
  FocusNode get cashAtHandFocusNode => _cashAtHandFocusNode;

  late Command1<void, BuildContext> openRegisterCommand;

  late Command1<void, BuildContext> requestFocusCommand;

  @override
  void bind(BuildContext context) {
    openRegisterCommand = Command1<void, BuildContext>(_openRegister);
    requestFocusCommand = Command1<void, BuildContext>(_requestFocus);
  }

  Future<Result<void>> _requestFocus(BuildContext context) async {
    FocusScope.of(context).requestFocus(_cashAtHandFocusNode);
    return Result.success(null);
  }

  Future<Result<void>> _openRegister(BuildContext context) async {
    final openRegisterDto = OpenRegisterDto(
      openingCashAtHand: double.parse(cashAtHandController.text),
      note: noteController.text,
    );
    final result = await openRegister(openRegisterDto);
    result.when(
      onSuccess: (value) {
        SpotstockNavigation.goBack();
        SpotstockNavigation.goTo(SpotstockMobileRoutes.selectApp);
        return Result.success(null);
      },
      onFailure: (error) {
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
