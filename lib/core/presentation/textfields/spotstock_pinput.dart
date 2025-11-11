import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockPinput extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onCompleted;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final FocusNode? focusNode;
  const SpotstockPinput({
    super.key,
    this.controller,
    required this.onCompleted,
    this.obscureText = true,
    this.validator,
    this.errorText,
    this.focusNode,
  });

  static PinTheme defaultPinTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = SpotstockSizes.s40 * SpotstockSizes.s2; // padding on both sides
    final spacingBetweenPins = SpotstockSizes.s10 * SpotstockSizes.s5; // 5 gaps between 6 pins
    final availableWidth = screenWidth - horizontalPadding - spacingBetweenPins;
    final calculatedSize = availableWidth / SpotstockSizes.s6; // divide by number of pins
    final maxSize = SpotstockSizes.s64;
    final pinSize = calculatedSize.clamp(SpotstockSizes.s40, maxSize);

    return PinTheme(
      width: pinSize,
      height: pinSize,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: SpotstockSizes.s1,
        ),
      ),
      textStyle: TextStyle(
        fontSize: SpotstockSizes.s16,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  static PinTheme focusedPinTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final baseTheme = defaultPinTheme(context);
    return baseTheme.copyWith(
      decoration: baseTheme.decoration?.copyWith(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: SpotstockSizes.s1,
        ),
      ),
    );
  }

  static PinTheme errorPinTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final baseTheme = defaultPinTheme(context);
    return baseTheme.copyWith(
      decoration: baseTheme.decoration?.copyWith(
        border: Border.all(
          color: theme.colorScheme.error,
          width: SpotstockSizes.s1_2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Pinput(
      length: SpotstockSizes.s6.toInt(),
      obscureText: obscureText,
      errorText: errorText,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme(context),
      focusedPinTheme: focusedPinTheme(context),
      errorPinTheme: errorPinTheme(context),
      validator: validator,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      cursor: Align(
        alignment: Alignment.center,
        child: Container(
          width: SpotstockSizes.s1,
          height: SpotstockSizes.s20,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(SpotstockSizes.s1),
          ),
        ),
      ),
      onCompleted: (pin) {
        onCompleted?.call(pin);
      },
    );
  }
}
