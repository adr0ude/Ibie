import 'package:flutter/material.dart';

InputDecoration bigDecorationForm(String label, {bool enabled = true, Size? size, double? fontSize}) {
  final verticalPadding = size != null ? 12.0 : 10.0;

  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.fromLTRB(12, verticalPadding, 12, 12),
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
    labelStyle: TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w300,
      color: const Color(0xFF767474),
    ),
  );
}