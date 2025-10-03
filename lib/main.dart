import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'core/constants/strings/spotstock_strings.dart';
import 'core/di/di.dart';
import 'core/routing/router.dart';
import 'features/platform/platform_service.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const SpotstockInventory());
}

class SpotstockInventory extends StatelessWidget {
  const SpotstockInventory({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = getIt<PlatformService>().isMobile;
    return MaterialApp.router(
      title: SpotstockStrings.spotstockInventory,
      routerConfig: isMobile ? SpotstockRouter.mobileRouter : SpotstockRouter.desktopRouter,
    );
  }
}
