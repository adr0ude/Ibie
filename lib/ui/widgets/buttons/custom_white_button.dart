import 'dart:async';
import 'package:flutter/material.dart';

class CustomWhiteButton extends StatelessWidget {
  final String label;
  final FutureOr<void> Function()? onPressed;
  final Size? size;
  final bool isDisabled;
  final bool isGreen;

  const CustomWhiteButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size,
    this.isDisabled = false,
    this.isGreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isDisabled ? Color(0xFFDBD9D9) : Color(0xFFFFFFFF),
        foregroundColor: isGreen ? Color(0xFF71A151) : Color(0xFF9A31C9),
        side: BorderSide(color: isGreen ? Color(0xFF71A151) : Color(0xFF9A31C9), width: 1.5),
        minimumSize: size ?? const Size(331, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isGreen ? Color(0xFF71A151) : Color(0xFF9A31C9),
        ),
      ),
    );
  }
}