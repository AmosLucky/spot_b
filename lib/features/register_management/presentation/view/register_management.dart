import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/register_management_view_model.dart';
import '../widget/spotstock_register_widget.dart';

class RegisterManagement extends StatelessWidget {
  final RegisterManagementViewModel viewModel;
  const RegisterManagement({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.posRegisters,
                  withBackButton: true,
                  trailing: Row(
                    children: [
                      if (viewModel.showDownloadButton)
                        SpotstockIconButton(
                          icon: Icon(
                            Icons.download,
                            size: SpotstockSizes.s18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          color: Theme.of(context).colorScheme.onPrimary,
                          onPressed: () {},
                        )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SpotstockSizes.s10,
                    left: SpotstockSizes.s16,
                    right: SpotstockSizes.s16,
                  ),
                  child: Text(SpotstockStrings.registerManagementSubtitle),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SpotstockSizes.s10,
                    left: SpotstockSizes.s16,
                    right: SpotstockSizes.s8,
                    bottom: SpotstockSizes.s10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SpotstockTextField(
                          controller: viewModel.searchController,
                          hintText: SpotstockStrings.searchStaff,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: SpotstockSizes.s18,
                          ),
                          onChanged: (value) => viewModel.onSearch(value ?? SpotstockStrings.EMPTY),
                          suffixIcon: SpotstockIconButton(
                            color: Theme.of(context).colorScheme.onSurface,
                            onPressed: () {
                              viewModel.clearSearch();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: SpotstockSizes.s18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: SpotstockSizes.s5),
                      IconButton(
                        onPressed: () {
                          viewModel.onTapFilter(context);
                        },
                        icon: Icon(
                          Icons.filter_alt,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: SpotstockSizes.s1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SpotstockSizes.s16,
                    vertical: SpotstockSizes.s8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${SpotstockStrings.total}: ${viewModel.total}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: SpotstockSizes.s15),
                      Text(
                        '${SpotstockStrings.open}: ${viewModel.open}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: SpotstockSizes.s15),
                      Text(
                        '${SpotstockStrings.closed}: ${viewModel.closed}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: SpotstockSizes.s1,
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: Scrollbar(
                      child: (viewModel.getPOSRegistersStreamCommand.running && (viewModel.filteredRegisters == null || viewModel.isFiltering))
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SpotstockProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(height: SpotstockSizes.s16),
                                Text(SpotstockStrings.gettingRegisters),
                              ],
                            )
                          : viewModel.filteredRegisters!.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info,
                                      size: SpotstockSizes.s48,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                    SizedBox(height: SpotstockSizes.s16),
                                    Text(SpotstockStrings.noRegistersFound),
                                  ],
                                )
                              : RefreshIndicator(
                                  onRefresh: () => viewModel.getPOSRegistersStreamCommand.execute(),
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                      top: SpotstockSizes.s10,
                                      left: SpotstockSizes.s16,
                                      right: SpotstockSizes.s16,
                                      bottom: SpotstockSizes.s16,
                                    ),
                                    itemCount: viewModel.filteredRegisters!.length,
                                    itemBuilder: (context, index) {
                                      final register = viewModel.filteredRegisters![index];
                                      return SpotstockRegisterWidget(
                                        register: register,
                                        onRegisterSelected: (register) async {
                                          await viewModel.onRegisterSelected(context, register);
                                        },
                                      );
                                    },
                                  ),
                                ),
                    ),
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
