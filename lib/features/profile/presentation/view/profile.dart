import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/di/di.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/appbars/spotstock_appbar.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/views/spotstock_view.dart';
import '../view_model/profile_view_model.dart';

const int settingsSupportingTextColor = 153;

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
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: SpotstockSizes.s16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          radius: SpotstockSizes.s40,
                        ),
                        SizedBox(height: SpotstockSizes.s10),
                        Center(
                          child: Text(
                            "${viewModel.spotstockUser?.firstName} ${viewModel.spotstockUser?.lastName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: SpotstockSizes.s18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outlined,
                              size: SpotstockSizes.s18,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                            ),
                            SizedBox(width: SpotstockSizes.s5),
                            Text(
                              viewModel.spotstockUser?.roleDisplayName ?? SpotstockStrings.EMPTY,
                              style: TextStyle(
                                fontSize: SpotstockSizes.s14,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SpotstockSizes.s30),
                        Text(
                          SpotstockStrings.personalInformation,
                          style: TextStyle(
                            fontSize: SpotstockSizes.s13,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                          ),
                        ),
                        SizedBox(height: SpotstockSizes.s15),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: SpotstockSizes.s18,
                            ),
                            SizedBox(width: SpotstockSizes.s16),
                            Text(
                              viewModel.spotstockUser?.email ?? SpotstockStrings.EMPTY,
                            ),
                          ],
                        ),
                        SizedBox(height: SpotstockSizes.s10),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: SpotstockSizes.s18,
                            ),
                            SizedBox(width: SpotstockSizes.s16),
                            Text(
                              viewModel.spotstockUser?.phone ?? SpotstockStrings.EMPTY,
                            ),
                          ],
                        ),
                        SizedBox(height: SpotstockSizes.s15),
                        Divider(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                        ),
                        SizedBox(height: SpotstockSizes.s15),
                        Text(
                          SpotstockStrings.settings,
                          style: TextStyle(
                            fontSize: SpotstockSizes.s13,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                          ),
                        ),
                        SizedBox(height: SpotstockSizes.s10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              SpotstockStrings.theme,
                              style: TextStyle(
                                fontSize: SpotstockSizes.s13,
                              ),
                            ),
                            SegmentedButton<ThemeMode>(
                              multiSelectionEnabled: false,
                              showSelectedIcon: false,
                              selected: {viewModel.themeMode},
                              onSelectionChanged: (themeMode) {
                                viewModel.onThemeChanged(themeMode.first);
                              },
                              segments: [
                                ButtonSegment(
                                  value: ThemeMode.light,
                                  label: Text(
                                    SpotstockStrings.light,
                                    style: TextStyle(fontSize: SpotstockSizes.s11),
                                  ),
                                ),
                                ButtonSegment(
                                  value: ThemeMode.system,
                                  label: Text(
                                    SpotstockStrings.system,
                                    style: TextStyle(fontSize: SpotstockSizes.s11),
                                  ),
                                ),
                                ButtonSegment(
                                  value: ThemeMode.dark,
                                  label: Text(
                                    SpotstockStrings.dark,
                                    style: TextStyle(fontSize: SpotstockSizes.s11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: SpotstockSizes.s15),
                        Divider(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                        ),
                        SizedBox(height: SpotstockSizes.s15),
                        Text(
                          SpotstockStrings.helpAndSupport,
                          style: TextStyle(
                            fontSize: SpotstockSizes.s13,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                          ),
                        ),
                        SizedBox(height: SpotstockSizes.s15),
                        Divider(
                          color: Theme.of(context).colorScheme.onSurface.withAlpha(settingsSupportingTextColor),
                        ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
