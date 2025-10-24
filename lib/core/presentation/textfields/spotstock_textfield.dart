import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockInputDecorations {
  SpotstockInputDecorations();

  static InputDecoration defaultInputDecoration(
    BuildContext context, {
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    String? counterText,
  }) {
    final ThemeData theme = Theme.of(context);
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: theme.colorScheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: theme.colorScheme.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: theme.colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: theme.colorScheme.error, width: SpotstockSizes.s1_2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: theme.colorScheme.error),
      ),
      errorStyle: TextStyle(
        fontSize: SpotstockSizes.s12,
        fontWeight: FontWeight.w700,
        color: theme.colorScheme.error,
      ),
      errorMaxLines: 1,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpotstockSizes.s10,
        vertical: SpotstockSizes.s16,
      ),
      fillColor: theme.colorScheme.surfaceContainerHighest,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: SpotstockSizes.s12,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.onSurface,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      counterText: counterText,
    );
  }
}

class SpotstockTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<String>? autofillHints;
  final int? maxLength;
  final String? counterText;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final bool? enabled;
  final int? maxLines;
  final String? initialValue;
  const SpotstockTextField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.autofillHints,
    this.maxLength,
    this.counterText,
    this.style,
    this.inputFormatters,
    this.onChanged,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.maxLines,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      focusNode: focusNode,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: textAlign,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      autofillHints: autofillHints,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: style ??
          TextStyle(
            fontSize: SpotstockSizes.s16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
      cursorColor: Theme.of(context).colorScheme.primary,
      cursorWidth: SpotstockSizes.s1,
      cursorHeight: SpotstockSizes.s20,
      decoration: SpotstockInputDecorations.defaultInputDecoration(
        context,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: counterText,
      ),
      maxLines: maxLines,
    );
  }
}
