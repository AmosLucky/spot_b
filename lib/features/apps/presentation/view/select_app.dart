import 'package:flutter/material.dart';

import '../../../../core/assets/spotstock_assets.dart';
import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/permissions/spotstock_permissions.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/routing/router.dart';
import '../view_model/select_app_view_model.dart';
import '../widgets/spotstock_app_widget.dart';

class SelectApp extends StatelessWidget {
  final SelectAppViewModel viewModel;
  const SelectApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    SpotstockAppbar(
                      title: SpotstockStrings.apps,
                      withBackButton: true,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * SpotstockSizes.s0_05),
                            Wrap(
                              spacing: SpotstockSizes.s24,
                              runSpacing: SpotstockSizes.s24,
                              children: [
                                if (viewModel.userIsPermittedTo(SpotstockPermissions.managePosScreen))
                                  SpotstockAppWidget(
                                    name: SpotstockStrings.pointOfSale,
                                    iconPath: SpotstockIconAssets.pointOfSale,
                                    onTap: () {
                                      viewModel.onPOSPressed(context);
                                    },
                                  ),
                                if (viewModel.userIsPermittedTo(SpotstockPermissions.manageHotel))
                                  SpotstockAppWidget(
                                    name: SpotstockStrings.hotel,
                                    iconPath: SpotstockIconAssets.hotel,
                                    onTap: () {
                                      SpotstockNavigation.replace(SpotstockDesktopRoutes.hotel);
                                    },
                                  ),
                                if (viewModel.isAdmin == true)
                                  SpotstockAppWidget(
                                    name: SpotstockStrings.registerManagement,
                                    iconPath: SpotstockIconAssets.registerManagement,
                                    onTap: () {
                                      viewModel.onRegisterManagementPressed(context);
                                    },
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (viewModel.checkIfRegisterIsOpenCommand.running)
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
                            SpotstockStrings.checkingRegisterStatus,
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
        );
      },
    );
  }
}
