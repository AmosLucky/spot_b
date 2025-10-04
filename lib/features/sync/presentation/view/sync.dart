import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_floating_action_button.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/sync_view_model.dart';

class Sync extends StatelessWidget {
  const Sync({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SyncViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.waitingToSync,
                  trailing: SpotstockIconButton(
                    icon: Icon(
                      Icons.filter_alt,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: SpotstockSizes.s18,
                    ),
                    tooltip: SpotstockStrings.filter,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: SpotstockSizes.s10),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                  child: Column(
                    children: [
                      SpotstockTextField(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: SpotstockSizes.s18,
                        ),
                        suffixIcon: Icon(
                          Icons.cancel,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: SpotstockSizes.s18,
                        ),
                        hintText: SpotstockStrings.searchTransaction,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: SpotstockFloatingActionButton(
              onPressed: () {},
              icon: Icon(
                Icons.sync,
                color: Theme.of(context).colorScheme.onPrimary,
                size: SpotstockSizes.s18,
              ),
              label: SpotstockStrings.syncAll,
            ),
          ),
        );
      },
    );
  }
}
