import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/history_view_model.dart';

final GetIt getIt = GetIt.instance;

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<HistoryViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.transactionHistory,
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
          ),
        );
      },
    );
  }
}
