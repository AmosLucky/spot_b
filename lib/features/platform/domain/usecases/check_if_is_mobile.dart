import '../../services/platform_service.dart';

class CheckIfIsMobile {
  final PlatformService platformService;

  CheckIfIsMobile(this.platformService);

  bool call() {
    return platformService.isMobile;
  }
}
