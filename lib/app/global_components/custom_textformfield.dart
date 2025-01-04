import 'package:ezycourse/app/utils/color.dart';
import 'package:flutter/material.dart';

import 'custom_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool readOnly;
  final IconData? prefixIcon;
  final Widget? suffixIcon; // Changed this to accept Widget instead of IconData
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final bool obscureText;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.readOnly = false,
      this.suffixIcon, // Accepting Widget here
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.hintStyle,
      this.obscureText = false,
      this.validator,
      this.onChanged,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      style: CustomTextStyles.interBlack(color: Colors.white),
      maxLines: maxLines,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
                color: Colors.grey), // Default grey color for hint text
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon:
            suffixIcon, // Now it can accept any Widget, including IconButton
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: BORDER_COLOR, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: BORDER_COLOR, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: BORDER_COLOR, width: 1.0),
        ),
      ),
    );
  }
}
