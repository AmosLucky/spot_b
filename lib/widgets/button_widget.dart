import 'package:flutter/material.dart';
import '../../extensions/extensions.dart';
import '../../common/common.dart';
import '../../../common/provider/preference_settings_provider.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final Color buttonColor, titleColor, borderColor;
  final double paddingVertical, paddingHorizontal;

  const ButtonWidget({
    super.key,
    required this.onPress,
    required this.title,
    required this.buttonColor,
    required this.titleColor,
    required this.borderColor,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 1.0,
              color: borderColor,
            ),
            backgroundColor: buttonColor,
            alignment: Alignment.center,
            shadowColor: preferenceSettingsProvider.isDarkTheme
                ? blackColor20
                : grayColor,
            elevation: 3,
            padding: EdgeInsets.symmetric(
              vertical: paddingVertical,
              horizontal: paddingHorizontal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ButtonGradWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isLoading;
  final Color buttonColor, titleColor, borderColor;
  final double paddingVertical, paddingHorizontal;

  const ButtonGradWidget({
    super.key,
    required this.onPress,
    this.isLoading = false,
    required this.title,
    required this.buttonColor,
    required this.titleColor,
    required this.borderColor,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return GestureDetector(
          onTap: onPress,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLoading
                    ? [
                        Color(0xFF706490),
                        Color(0xFF5A4A7D)
                      ] // Lighter gradient colors for loading state
                    : [Color(0xFF473069), Color(0xFF3A2558)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: whiteColor,
                      strokeWidth: 1.0,
                    )
                  : Text(
                      title,
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
