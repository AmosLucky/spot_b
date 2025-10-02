import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/data/models/spotstock_user.dart';
import '../../../auth/domain/usecases/get_spotstock_user.dart';

class HomeViewModel extends SpotstockViewModel {
  final GetSpotstockUser getSpotstockUser;

  HomeViewModel(this.getSpotstockUser);

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
    SpotstockNavigation.goTo(SpotstockMobileRoutes.selectApp, context);
    return Result.success(null);
  }
}
