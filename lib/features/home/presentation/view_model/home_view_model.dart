import 'package:flutter/material.dart';

import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/view_models/spotstock_user_aware_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';

class HomeViewModel extends SpotstockUserAwareViewModel with SpotstockDialogMixin {
  HomeViewModel(
    super.getSpotstockUser,
  );

  Future<void> onAppsPressed(BuildContext context) async {
    SpotstockNavigation.goTo(SpotstockMobileRoutes.selectApp);
  }
}
