import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Function()? onPressed;
  Widget? child;
  Color? onPrimary;
  Color? primary;
  OutlinedBorder? shape;
  Size? fixedSize;
  double? elevation;
  CustomElevatedButton(
      {super.key,
      this.elevation,
      this.onPressed,
      required this.child,
      this.onPrimary,
      this.shape,
      this.fixedSize,
      this.primary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: elevation,
              onPrimary: onPrimary,
              primary: primary,
              shape: shape,
              fixedSize: fixedSize),
          onPressed: onPressed,
          child: child),
    );
  }
}
