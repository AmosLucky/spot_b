import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/shared/command.dart';
import 'package:spotstock_inventory/features/sync/domain/usecases/sync_offline_data.dart';

import '../../../../core/presentation/banners/spotstock_banner.dart';
import '../../../../core/presentation/haptic_feedback/spotstock_haptic_feedback.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/shared/result.dart';
import '../../../sync/presentation/view_model/sync_event/sync_event.dart';
import '../../domain/usecases/listen_for_network_change.dart';

class SpotstockNetworkAwareViewModel extends SpotstockViewModel with SpotstockBannerMixin {
  final ListenForNetworkChange _listenForNetworkChange;
  final SyncOfflineData syncOfflineData;
  SpotstockNetworkAwareViewModel(this._listenForNetworkChange, this.syncOfflineData);

  Command0<void>? _syncOfflineDataCommand;
  Command0<void>? get syncOfflineDataCommand => _syncOfflineDataCommand;

  StreamSubscription? _networkSubscription;

  @override
  void bind(BuildContext context) {
    _syncOfflineDataCommand ??= Command0<void>(_syncOfflineData);

    if (_networkSubscription != null) return;

    _networkSubscription = _listenForNetworkChange.call().listen(
      (isConnected) {
        if (context.mounted) {
          showNetworkBanner(context, isConnected);
          SpotstockHapticFeedback.networkStatusChanged();
          if (isConnected) {
            syncOfflineDataCommand?.execute();
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _networkSubscription?.cancel();
    super.dispose();
  }

  Future<Result<void>> _syncOfflineData() async {
    final syncOfflineDataStream = syncOfflineData();
    await for (final syncEvent in syncOfflineDataStream) {
      if (syncEvent is SyncStarted) {
        print("Sync started");
      } else if (syncEvent is SyncTaskStarted) {
        print("Starting: ${syncEvent.taskName}");
      } else if (syncEvent is SyncTaskSuccess) {
        print("Completed: ${syncEvent.taskName}");
      } else if (syncEvent is SyncTaskFailure) {
        print("Failed: ${syncEvent.taskName}");
      } else if (syncEvent is SyncCompleted) {
        print("All syncing complete");
      }
    }
    return Result.success(null);
  }
}
