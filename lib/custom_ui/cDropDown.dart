import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  Function(dynamic)? onChanged;
  String? Function(String?)? validator;
  Widget? icon;
  String? value;
  InputDecoration? decoration;
  List<String> itemsList;
  CustomDropDown(
      {super.key,
      this.onChanged,
      required this.itemsList,
      this.validator,
      this.icon,
      this.decoration,
      this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: itemsList
          .map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ))
          .toList(),
      onChanged: onChanged,
      validator: validator,
      icon: icon,
      value: value,
      decoration: decoration,
    );
  }
}
