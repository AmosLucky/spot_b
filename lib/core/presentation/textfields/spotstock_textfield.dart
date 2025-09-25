import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/sizes/spotstock_sizes.dart';

class SpotstockInputDecorations {
  SpotstockInputDecorations();

  static InputDecoration defaultInputDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? errorText,
    String? counterText,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: Colors.deepPurple.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: const BorderSide(color: Colors.deepPurple),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: BorderSide(color: Colors.deepPurple.shade100),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: const BorderSide(color: Colors.redAccent, width: SpotstockSizes.s1_2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SpotstockSizes.s5),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      errorStyle: const TextStyle(
        fontSize: SpotstockSizes.s12,
        fontWeight: FontWeight.w700,
        color: Colors.redAccent,
      ),
      errorMaxLines: 1,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SpotstockSizes.s10,
        vertical: SpotstockSizes.s16,
      ),
      fillColor: Colors.deepPurple.shade50,
      filled: true,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: SpotstockSizes.s12,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurple.shade300,
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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      autofillHints: autofillHints,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: style ??
          const TextStyle(
            fontSize: SpotstockSizes.s16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
      cursorColor: Colors.deepPurple,
      cursorWidth: SpotstockSizes.s1,
      cursorHeight: SpotstockSizes.s20,
      decoration: SpotstockInputDecorations.defaultInputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        counterText: counterText,
      ),
    );
  }
}
