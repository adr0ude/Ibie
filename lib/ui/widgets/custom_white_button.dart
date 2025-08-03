import 'package:flutter/material.dart';

class CustomWhiteButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Size? size;

  const CustomWhiteButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Color(0xFF9A31C9),
        side: BorderSide(color: Color(0xFF9A31C9), width: 1.5),
        minimumSize: size ?? const Size(331, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9A31C9),
        ),
      ),
    );
  }
}