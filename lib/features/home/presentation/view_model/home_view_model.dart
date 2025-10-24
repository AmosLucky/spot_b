import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/data/models/spotstock_user.dart';
import '../../../auth/domain/usecases/get_spotstock_user.dart';
import '../../../register_management/domain/usecases/check_if_register_is_open.dart';
import '../widgets/spotstock_open_register_form.dart';
import 'spotstock_open_register_form_view_model.dart';

class HomeViewModel extends SpotstockViewModel with SpotstockDialogMixin {
  final GetSpotstockUser getSpotstockUser;
  final CheckIfRegisterIsOpen checkIfRegisterIsOpen;

  HomeViewModel(this.getSpotstockUser, this.checkIfRegisterIsOpen);

  SpotstockUser? _spotstockUser;
  SpotstockUser? get spotstockUser => _spotstockUser;

  late Command1<void, BuildContext> navigateToSelectAppCommand;

  @override
  void bind(BuildContext context) async {
    navigateToSelectAppCommand = Command1<void, BuildContext>(_navigateToSelectApp);
    final result = await getSpotstockUser();
    result.when(
      onSuccess: (spotstockUser) {
        _spotstockUser = spotstockUser;
        notifyListeners();
      },
      onFailure: (error) {
        addError(error);
      },
    );
  }

  Future<Result<void>> _navigateToSelectApp(BuildContext context) async {
    final isRegisterOpenResult = await checkIfRegisterIsOpen();
    isRegisterOpenResult.when(
      onSuccess: (isRegisterOpen) {
        if (isRegisterOpen) {
          SpotstockNavigation.goTo(SpotstockMobileRoutes.selectApp);
          return Result.success(null);
        } else {
          final formViewModel = getIt<SpotstockOpenRegisterFormViewModel>()..bind(context);
          showSpotstockFormDialog(
            context,
            title: SpotstockStrings.openRegister,
            form: SpotstockOpenRegisterForm(
              viewModel: formViewModel,
              onFormValidated: () {},
            ),
            actions: [
              SpotstockPrimaryButton(
                enabled: !formViewModel.openRegisterCommand.running,
                color: Theme.of(context).colorScheme.primary,
                child: formViewModel.openRegisterCommand.running
                    ? SpotstockProgressIndicator()
                    : Text(
                        SpotstockStrings.openRegister,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                onPressed: () {
                  if (formViewModel.validateForm()) {
                    formViewModel.openRegisterCommand.execute(context);
                  }
                },
              )
            ],
          );
        }
      },
      onFailure: (error) {
        addError(error);
      },
    );

    return Result.success(null);
  }
}
