import 'dart:async';
import 'package:flutter/material.dart';

class CustomPurpleButton extends StatelessWidget {
  final String label;
  final FutureOr<void> Function()? onPressed;
  final Size? size;

  const CustomPurpleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF9A31C9),
        foregroundColor: const Color(0xFF9A31C9),
        minimumSize: size ?? const Size(331, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        disabledBackgroundColor: Color(0xFF9A31C9).withAlpha(128),
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