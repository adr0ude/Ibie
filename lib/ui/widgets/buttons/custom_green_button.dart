import 'dart:async';
import 'package:flutter/material.dart';

class CustomGreenButton extends StatelessWidget {
  final String label;
  final FutureOr<void> Function()? onPressed;
  final Size? size;

  const CustomGreenButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF71A151),
        foregroundColor: const Color(0xFF71A151),
        minimumSize: size ?? const Size(331, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        disabledBackgroundColor: Color(0xFF71A151).withAlpha(128),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}