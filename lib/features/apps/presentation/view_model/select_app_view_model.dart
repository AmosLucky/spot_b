import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/view_models/spotstock_user_aware_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../home/presentation/view_model/spotstock_open_register_form_view_model.dart';
import '../../../home/presentation/widgets/spotstock_open_register_form.dart';
import '../../../network_info/domain/usecases/check_and_update_network_status.dart';
import '../../../register_management/domain/usecases/check_if_register_is_open.dart';

class SelectAppViewModel extends SpotstockUserAwareViewModel with SpotstockDialogMixin {
  final CheckAndUpdateNetworkStatus checkAndUpdateNetworkStatus;
  final CheckIfRegisterIsOpen checkIfRegisterIsOpen;

  SelectAppViewModel(
    super.getSpotstockUser,
    this.checkAndUpdateNetworkStatus,
    this.checkIfRegisterIsOpen,
  );

  late Command0<bool> checkIfRegisterIsOpenCommand;

  @override
  void bind(BuildContext context) {
    super.bind(context);
    checkIfRegisterIsOpenCommand = Command0<bool>(_checkIfRegisterIsOpen)..addListener(notifyListeners);
  }

  Future<Result<bool>> _checkIfRegisterIsOpen() async {
    return await checkIfRegisterIsOpen();
  }

  Future<bool> _ensurePOSRegisterIsOpen(BuildContext context, String screenToNavigateTo) async {
    await checkIfRegisterIsOpenCommand.execute();
    final result = checkIfRegisterIsOpenCommand.result;
    if (!context.mounted) return false;
    if (result is Success<bool>) {
      if (result.data == true) {
        SpotstockNavigation.goTo(screenToNavigateTo);
        return true;
      } else {
        final formViewModel = getIt<SpotstockOpenRegisterFormViewModel>()
          ..bind(
            context,
            screenToNavigateTo: screenToNavigateTo,
          );
        await showSpotstockFormDialog(
          context,
          title: SpotstockStrings.openRegister,
          form: SpotstockOpenRegisterForm(
            viewModel: formViewModel,
            onFormValidated: () {},
          ),
          actions: [
            ListenableBuilder(
              listenable: formViewModel.openRegisterCommand,
              builder: (context, _) {
                return SpotstockPrimaryButton(
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
                      FocusScope.of(context).unfocus();
                      formViewModel.openRegisterCommand.execute(context);
                    }
                  },
                );
              },
            )
          ],
        );
      }
    }
    if (result is Failure<bool>) {
      addError(result.error);
    }
    return false;
  }

  Future<void> onPOSPressed(BuildContext context) async {
    await _ensurePOSRegisterIsOpen(context, SpotstockMobileRoutes.pos);
    if (!context.mounted) return;
  }

  Future<void> onRegisterManagementPressed(BuildContext context) async {
    if (!context.mounted) return;
    SpotstockNavigation.goTo(SpotstockMobileRoutes.registerManagement);
  }
}
