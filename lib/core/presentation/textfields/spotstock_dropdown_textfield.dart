import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../../constants/strings/spotstock_strings.dart';
import 'spotstock_textfield.dart';

class SpotstockDropdownTextField<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final bool? enabled;

  const SpotstockDropdownTextField({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: enabled == false ? null : onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      style: TextStyle(
        fontSize: SpotstockSizes.s16,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      hint: Text(
        hintText ?? SpotstockStrings.EMPTY,
        style: TextStyle(
          fontSize: SpotstockSizes.s12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      decoration: SpotstockInputDecorations.defaultInputDecoration(
        context,
        hintText: null,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
