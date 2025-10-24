import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../network_info/domain/usecases/check_and_update_network_status.dart';

class SelectAppViewModel extends SpotstockViewModel {
  final CheckAndUpdateNetworkStatus checkAndUpdateNetworkStatus;

  SelectAppViewModel(this.checkAndUpdateNetworkStatus);

  @override
  void bind(BuildContext context) async {
    // await checkAndUpdateNetworkStatus();
  }
}
