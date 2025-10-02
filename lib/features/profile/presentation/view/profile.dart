import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/di/di.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/profile_view_model.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<ProfileViewModel>();
    return ListenableBuilder(
      listenable: viewModel..bind(context),
      builder: (context, _) {
        return SpotstockView(
          content: Scaffold(
            body: Column(
              children: [
                SpotstockAppbar(
                  title: SpotstockStrings.profile,
                ),
                const SizedBox(height: SpotstockSizes.s10),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                  child: Column(
                    children: [
                      SpotstockPrimaryButton(
                        color: Theme.of(context).colorScheme.error,
                        child: Text(
                          SpotstockStrings.logout,
                          style: TextStyle(color: Theme.of(context).colorScheme.onError),
                        ),
                        onPressed: () {
                          viewModel.logoutCommand.execute(context);
                        },
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
