// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../core/constants/durations/spotstock_durations.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/data/models/spotstock_user.dart';
import '../../../auth/domain/usecases/get_last_login_time.dart';
import '../../../auth/domain/usecases/get_spotstock_user.dart';
import '../../../auth/domain/usecases/get_token.dart';

class SplashViewModel extends SpotstockViewModel {
  final GetToken getToken;
  final GetSpotstockUser getSpotstockUser;
  final GetLastLoginTime getLastLoginTime;

  SplashViewModel(
    this.getToken,
    this.getSpotstockUser,
    this.getLastLoginTime,
  );

  SpotstockUser? _spotstockUser;
  DateTime? _lastLoginTime;
  String? _token;

  late Command1<void, BuildContext> navigateIntoAppCommand;

  @override
  Future<void> bind(BuildContext context) async {
    navigateIntoAppCommand = Command1<void, BuildContext>(_navigateIntoApp);
    final tokenResult = await getToken();
    final spotstockUserResult = await getSpotstockUser();
    final lastLoginTimeResult = await getLastLoginTime();

    lastLoginTimeResult.when(
      onSuccess: (lastLoginTime) {
        _lastLoginTime = lastLoginTime;
      },
      onFailure: (error) {
        addError(error);
      },
    );
    spotstockUserResult.when(
      onSuccess: (spotstockUser) {
        _spotstockUser = spotstockUser;
      },
      onFailure: (error) {
        addError(error);
      },
    );
    tokenResult.when(
      onSuccess: (token) {
        _token = token;
      },
      onFailure: (error) {
        addError(error);
      },
    );
    notifyListeners();

    navigateIntoAppCommand.execute(context);
  }

  Future<Result<void>> _navigateIntoApp(BuildContext context) async {
    await Future.delayed(SpotstockDurations.splashScreenDisplayTime);
    if (_token != null &&
        _spotstockUser != null &&
        _lastLoginTime != null &&
        !_hasElapsedSessionTime(_lastLoginTime!)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SpotstockNavigation.goTo(SpotstockMobileRoutes.home, context);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SpotstockNavigation.goTo(SpotstockMobileRoutes.login, context);
      });
    }
    return Result.success(null);
  }

  bool _hasElapsedSessionTime(DateTime lastLoginTime) {
    final now = DateTime.now();
    final difference = now.difference(lastLoginTime);
    if (difference.inHours > SpotstockDurations.sessionTimeInHours) {
      return true;
    }
    return false;
  }
}
