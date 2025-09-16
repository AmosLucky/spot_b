import 'dart:io';

import '../../core/constants/strings/spotstock_strings.dart';
import '../../core/enums/app_platform.dart';

class PlatformService {
  AppPlatform get currentPlatform {
    if (Platform.isAndroid) {
      return AppPlatform.mobile;
    } else if (Platform.isIOS) {
      return AppPlatform.mobile;
    } else if (Platform.isWindows) {
      return AppPlatform.desktop;
    } else if (Platform.isMacOS) {
      return AppPlatform.desktop;
    }
    throw UnsupportedError(SpotstockStrings.UNKNOWN_PLATFORM);
  }

  bool get isMobile => currentPlatform == AppPlatform.mobile;
  bool get isDesktop => currentPlatform == AppPlatform.desktop;
}
