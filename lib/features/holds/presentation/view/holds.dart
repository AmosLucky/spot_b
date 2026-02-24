import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/holds_view_model.dart';
import '../widget/spotstock_hold_widget.dart';

class Holds extends StatelessWidget {
  final HoldsViewModel viewModel;
  const Holds({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, child) => SpotstockView(
        content: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  SpotstockAppbar(
                    title: SpotstockStrings.holds,
                    withBackButton: true,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => viewModel.getHoldsCommand.execute(),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: Scrollbar(
                          controller: viewModel.scrollController,
                          child: SingleChildScrollView(
                            controller: viewModel.scrollController,
                            padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: SpotstockSizes.s10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(SpotstockStrings.manageHoldsTapAHoldForActions)),
                                    const SizedBox(width: SpotstockSizes.s16),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SpotstockSizes.s16,
                                        vertical: SpotstockSizes.s8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainer,
                                        borderRadius: BorderRadius.circular(SpotstockSizes.s1000),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.pause_circle_filled,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          const SizedBox(width: SpotstockSizes.s4),
                                          Text(
                                            "${viewModel.holdCount} ${viewModel.isHoldsCountMoreThanOne ? SpotstockStrings.holdsSmallLetter : SpotstockStrings.holdSmallLetter}",
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onSurface,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: SpotstockSizes.s16),
                                SpotstockTextField(
                                  hintText: SpotstockStrings.searchByReferenceCodeCustomerNameOrWarehouse,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    size: SpotstockSizes.s18,
                                  ),
                                  suffixIcon: SpotstockIconButton(
                                    onPressed: () => viewModel.clearSearch(),
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Theme.of(context).colorScheme.onSurface,
                                      size: SpotstockSizes.s18,
                                    ),
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  controller: viewModel.searchController,
                                  onChanged: (value) => viewModel.onSearch(value ?? ''),
                                ),
                                const SizedBox(height: SpotstockSizes.s10),
                                if (viewModel.filteredHolds.isEmpty && viewModel.getHoldsCommand.running)
                                  Column(
                                    children: [
                                      SizedBox(height: screenHeight * SpotstockSizes.s0_2),
                                      SpotstockProgressIndicator(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      SizedBox(height: SpotstockSizes.s8),
                                      Text(SpotstockStrings.gettingHolds),
                                    ],
                                  ),
                                if (viewModel.filteredHolds.isEmpty && !viewModel.getHoldsCommand.running)
                                  Column(
                                    children: [
                                      SizedBox(height: screenHeight * SpotstockSizes.s0_2),
                                      Icon(
                                        Icons.search_off,
                                        color: Theme.of(context).colorScheme.onSurface,
                                        size: SpotstockSizes.s34,
                                      ),
                                      SizedBox(height: SpotstockSizes.s8),
                                      Text(SpotstockStrings.noHoldsFound),
                                    ],
                                  ),
                                if (viewModel.filteredHolds.isNotEmpty)
                                  ...viewModel.filteredHolds.map(
                                    (hold) => SpotstockHoldWidget(
                                      hold: hold,
                                      onTap: () => viewModel.onHoldSelected(context, hold),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (viewModel.deleteHoldCommand?.running == true)
                Material(
                  color: Theme.of(context).colorScheme.surface.withAlpha(186),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpotstockProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(height: SpotstockSizes.s5),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          SpotstockStrings.voidingHold,
                          style: TextStyle(
                            fontSize: SpotstockSizes.s10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
