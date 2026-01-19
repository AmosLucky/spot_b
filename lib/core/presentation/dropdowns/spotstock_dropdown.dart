import 'package:flutter/material.dart';

import '../../constants/sizes/spotstock_sizes.dart';
import '../buttons/spotstock_icon_button.dart';
import '../textfields/spotstock_textfield.dart';

class SpotstockDropdown<T> extends StatelessWidget {
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Widget? prefixIcon;
  final bool? enabled;
  final TextStyle? style;
  final String? errorText;

  const SpotstockDropdown({
    super.key,
    this.hintText,
    this.value,
    this.items,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled,
    this.style,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: enabled == false ? null : onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: SpotstockInputDecorations.defaultInputDecoration(
        context,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: SpotstockIconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: theme.colorScheme.onSurface,
            size: SpotstockSizes.s24,
          ),
        ),
        errorText: errorText,
      ),
      style: style ??
          TextStyle(
            fontSize: SpotstockSizes.s16,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
      icon: const SizedBox.shrink(),
      isExpanded: true,
      isDense: true,
      dropdownColor: theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(SpotstockSizes.s5),
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
    );
  }
}
