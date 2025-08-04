import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Size? size;

  const CustomFavoriteButton({super.key, required this.onPressed, this.size});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF9A31C9),
        side: const BorderSide(color: Color(0xFF9A31C9), width: 1.5),
        minimumSize: size ?? const Size(52, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: const Icon(Icons.star_border, color: Color(0xFF9A31C9), size: 28),
    );
  }
}