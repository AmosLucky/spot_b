import 'package:flutter/material.dart';

import '../../../../core/assets/spotstock_assets.dart';
import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
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
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.apps,
                  withBackButton: true,
                ),
                const SizedBox(height: SpotstockSizes.s10),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * SpotstockSizes.s0_1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SpotstockAppWidget(
                            name: SpotstockStrings.pointOfSale,
                            iconPath: SpotstockAssets.pointOfSale,
                            onTap: () {
                              print('point of sale');
                            },
                          ),
                          SpotstockAppWidget(
                            name: SpotstockStrings.hotel,
                            iconPath: SpotstockAssets.hotel,
                            onTap: () {
                              print('hotel');
                            },
                          ),
                        ],
                      )
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
