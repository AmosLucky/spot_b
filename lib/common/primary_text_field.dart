
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class PrimaryTextField extends StatefulWidget {
  final String hintText;
  final String title;
  final int? maxLength;
  final Widget? prefixIcon;
  final String? counter;
  final bool obscure;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String? v)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? enabled;
  final int? maxLines;
  final Function(String?)? onSaved;
  final bool? enableInteractiveSelection;
  final FocusNode? focusNode;
  final double? titleSize;
  final Function(String)? validate;
  final Color? fillColor;
  final Function(String)? onFieldSubmitted;
  const PrimaryTextField(
      {Key? key,
        this.controller,
        this.inputFormatters,
        this.onFieldSubmitted,
        this.prefixIcon,
        this.onChanged,
        this.onEditingComplete,
        this.onTap,
        this.maxLength,
        this.keyboardType,
        this.onSaved,
        this.titleSize,
        this.validate,
        this.suffixIcon,
        required this.hintText,
        required this.title,
        this.obscure = false,
        this.enabled, this.maxLines = 1, this.counter = '', this.enableInteractiveSelection, this.focusNode, this.fillColor = const Color(0xffFCFDFC)})
      : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool hasTitle = false;


  @override
  Widget build(BuildContext context) {

    if(widget.title != '') {
      setState(() {
        hasTitle = true;
      });
    } else {
      setState(() {
        hasTitle = false;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) Text(
          widget.title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: widget.titleSize ?? 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (hasTitle) SizedBox(
          height: 12.sp,
        ),
        TextFormField(
          validator: (e) {
            return widget.validate == null ? null : widget.validate!(e!);
          },
          enabled: widget.enabled,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          cursorColor: Colors.purple,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.obscure,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14),
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(2),
              child: widget.suffixIcon,
            ),
            counterText: widget.counter != '' ? widget.counter : "",
            counterStyle: TextStyle(
                letterSpacing: -0.2,
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w300),
            filled: true,
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon,
            contentPadding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            hintText: widget.hintText,
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1.3, color: Color(0xffDEE2DF)),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1.3, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14.sp, color: Colors.red),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1.3, color: Color(0xffDEE2DF)),
                borderRadius: BorderRadius.circular(12)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1.3, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 8, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)
            ),
            hintStyle: TextStyle(
                letterSpacing: -0.2,
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.w300),
          ),
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          textAlignVertical: TextAlignVertical.center,
          focusNode: widget.focusNode,
        ),
      ],
    );
  }
}
