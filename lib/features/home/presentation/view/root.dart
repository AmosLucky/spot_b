import 'package:flutter/material.dart';

import '../../../history/presentation/view/history.dart';
import '../../../network_info/presentation/view/spotstock_network_aware_view.dart';
import '../../../profile/presentation/view/profile.dart';
import '../../../summary/presentation/view/summary.dart';
import '../../../sync/presentation/view/sync.dart';
import '../view_model/root_view_model.dart';
import '../widgets/spotstock_bottom_nav_bar.dart';
import 'home.dart';

class Root extends StatelessWidget {
  final RootViewModel viewModel;
  const Root({super.key, required this.viewModel});

  List<Widget> get views => [
        Home(),
        History(),
        Sync(),
        Summary(),
        Profile(),
      ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, child) {
        return SpotstockNetworkAwareView(
          child: Scaffold(
            body: views[viewModel.selectedIndex],
            bottomNavigationBar: SpotstockBottomNavBar(
              selectedIndex: viewModel.selectedIndex,
              onTap: (index) {
                viewModel.setSelectedIndex(index);
              },
            ),
          ),
        );
      },
    );
  }
}
