import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFavoriteButton extends StatelessWidget {
  final FutureOr<void> Function()? onPressed;
  final String icon;

  const CustomFavoriteButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF9A31C9),
        side: const BorderSide(color: Color(0xFF9A31C9), width: 1.5),
        minimumSize: const Size(52, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: SvgPicture.asset(
        icon,
        width: 24.99,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }
}