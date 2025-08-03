import 'package:flutter/material.dart';

InputDecoration decorationForm(String label, {bool enabled = true, Size? size}) {

  final verticalPadding = size != null ? (size.height - 20).clamp(0, double.infinity) / 2 : 10.0;
  
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.symmetric(
      vertical: verticalPadding,
      horizontal: 12,
    ),
    fillColor: enabled ? const Color(0xFFFFFFFF) : const Color(0xFFDBD9D9),
    filled: true,
    errorStyle: const TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF9A31C9)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF9A31C9), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF9A31C9), width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF9A31C9), width: 1),
    ),
    labelStyle: const TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: Color(0xFF767474),
    ),
  );
}