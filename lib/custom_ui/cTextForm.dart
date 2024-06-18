import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  String? labelText;
  Widget? prefixIcon, suffixIcon;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  Function(String)? onChanged;
  TextInputType? keyboardType;
  bool obscureText;
  String? initialValue;

  CustomTextFormField(
      {super.key,
      this.labelText,
      this.initialValue,
      required this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.inputFormatters,
      this.onChanged,
      this.obscureText = false,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
