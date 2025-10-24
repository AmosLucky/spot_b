import 'package:flutter/material.dart';

import '../../../../core/presentation/banners/spotstock_banner.dart';
import '../../../../core/presentation/haptic_feedback/spotstock_haptic_feedback.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../domain/usecases/listen_for_network_change.dart';

class SpotstockNetworkAwareViewModel extends SpotstockViewModel with SpotstockBannerMixin {
  final ListenForNetworkChange _listenForNetworkChange;
  SpotstockNetworkAwareViewModel(this._listenForNetworkChange);

  @override
  void bind(BuildContext context) {
    _listenForNetworkChange.call().listen(
      (isConnected) {
        if (context.mounted) {
          showNetworkBanner(context, isConnected);
          SpotstockHapticFeedback.networkStatusChanged();
        }
      },
    );
  }
}
