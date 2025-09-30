import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../auth/domain/usecases/remove_last_login_time.dart';
import '../../../auth/domain/usecases/remove_spotstock_user.dart';
import '../../../auth/domain/usecases/remove_token.dart';
import '../../constants/spotstock_webview_constants.dart';

class WebviewViewModel extends SpotstockViewModel {
  final RemoveLastLoginTime removeLastLoginTime;
  final RemoveToken removeToken;
  final RemoveSpotstockUser removeSpotstockUser;

  WebviewViewModel(this.removeLastLoginTime, this.removeToken, this.removeSpotstockUser);

  late Command1<void, BuildContext> logoutCommand;

  late WebViewController _webviewController;
  WebViewController get webviewController => _webviewController;

  @override
  void bind(BuildContext context) {
    logoutCommand = Command1<void, BuildContext>(_logout);
    _webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {},
          onPageFinished: (url) {},
        ),
      )
      ..loadRequest(Uri.parse(SpotstockWebviewConstants.websiteDashboardUrl));
  }

  Future<Result<void>> _logout(BuildContext context) async {
    removeLastLoginTime();
    removeToken();
    SpotstockNavigation.replace(SpotstockMobileRoutes.login, context);
    return Result.success(null);
  }
}
