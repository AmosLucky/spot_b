import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/buttons/spotstock_secondary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/data/models/spotstock_user.dart';
import '../../../auth/domain/usecases/get_spotstock_user.dart';
import '../../../auth/domain/usecases/remove_last_login_time.dart';
import '../../../auth/domain/usecases/remove_token.dart';

class ProfileViewModel extends SpotstockViewModel with SpotstockDialogMixin {
  final RemoveLastLoginTime removeLastLoginTime;
  final GetSpotstockUser getSpotstockUser;
  final RemoveToken removeToken;

  ProfileViewModel(this.removeLastLoginTime, this.getSpotstockUser, this.removeToken);

  late Command1<void, BuildContext> logoutCommand;

  SpotstockUser? _spotstockUser;
  SpotstockUser? get spotstockUser => _spotstockUser;

  @override
  void bind(BuildContext context) async {
    logoutCommand = Command1<void, BuildContext>(_logout);
    final result = await getSpotstockUser();
    result.when(
      onSuccess: (spotstockUser) {
        _spotstockUser = spotstockUser;
      },
      onFailure: (error) {
        addError(error);
      },
    );
    notifyListeners();
  }

  Future<Result<void>> _logout(BuildContext context) async {
    showSpotstockDialog(
      context,
      icon: Icon(Icons.logout),
      title: SpotstockStrings.logout,
      description: SpotstockStrings.areYouSureYouWantToLogout,
      actions: [
        SpotstockPrimaryButton(
          color: Theme.of(context).colorScheme.error,
          child: Text(
            SpotstockStrings.yesLogout,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {
            removeLastLoginTime();
            removeToken();
            SpotstockNavigation.replace(SpotstockMobileRoutes.login, context);
          },
        ),
        SizedBox(height: SpotstockSizes.s16),
        SpotstockSecondaryButton(
          child: Text(
            SpotstockStrings.noCancel,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: () {
            SpotstockNavigation.goBack(context);
          },
        ),
      ],
    );

    return Result.success(null);
  }
}
