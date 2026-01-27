import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/constants/keys/spotstock_app_keys.dart';
import 'core/constants/strings/spotstock_strings.dart';
import 'core/di/di.dart';
import 'core/routing/navigation.dart';
import 'core/routing/router.dart';
import 'features/app/presentation/view_models/app_view_model.dart';

final GetIt getIt = GetIt.instance;

//247okolo@gmail.com
//spotenugu123

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  SpotstockNavigation.init(getIt<AppViewModel>().isMobile
      ? SpotstockRouter.mobileRouter
      : SpotstockRouter.desktopRouter);
  runApp(const SpotstockInventory());
}

class SpotstockInventory extends StatelessWidget {
  const SpotstockInventory({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<AppViewModel>();
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return MaterialApp.router(
          title: SpotstockStrings.spotstockInventory,
          scaffoldMessengerKey: spotstockScaffoldMessengerKey,
          routerConfig:
               viewModel.isMobile ?
              SpotstockRouter.mobileRouter
           : SpotstockRouter.desktopRouter,

          themeMode: viewModel.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
        );
      },
    );
  }
}
