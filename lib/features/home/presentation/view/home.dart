import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/di/di.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_floating_action_button.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/home_view_model.dart';
import '../widgets/spotstock_dashboard_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<HomeViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.dashboard,
                ),
                const SizedBox(height: SpotstockSizes.s10),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${SpotstockStrings.welcomeWithComma} ${viewModel.spotstockUser?.firstName} ${SpotstockStrings.waveHand}',
                        style: TextStyle(
                          fontSize: SpotstockSizes.s16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: SpotstockSizes.s16),
                      // SpotstockDashboardCard(
                      //   title: SpotstockStrings.todaysSales,
                      //   value: 100.0,
                      //   icon: Icon(
                      //     Icons.shopping_bag,
                      //     color: Theme.of(context).colorScheme.onSurface,
                      //     size: SpotstockSizes.s18,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: SpotstockFloatingActionButton(
              onPressed: () {
                viewModel.navigateToSelectAppCommand.execute(context);
              },
              icon: Icon(
                Icons.storefront,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SpotstockSizes.s18,
              ),
            ),
          ),
        );
      },
    );
  }
}
