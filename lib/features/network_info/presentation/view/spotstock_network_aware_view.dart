import 'package:flutter/material.dart';

import '../../../../core/di/di.dart';
import '../view_model/spotstock_network_aware_view_model.dart';

class SpotstockNetworkAwareView extends StatefulWidget {
  const SpotstockNetworkAwareView({super.key, required this.child});
  final Widget child;

  @override
  State<SpotstockNetworkAwareView> createState() => _SpotstockNetworkAwareViewState();
}

class _SpotstockNetworkAwareViewState extends State<SpotstockNetworkAwareView> {
  @override
  void initState() {
    super.initState();
    getIt<SpotstockNetworkAwareViewModel>().bind(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SpotstockNetworkAwareViewModel>();
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return widget.child;
      },
    );
  }
}
