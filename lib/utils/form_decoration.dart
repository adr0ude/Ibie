import 'package:flutter/material.dart';

InputDecoration decorationForm(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    fillColor: Color(0xFFFFFFFF),
    filled: true,
    errorStyle: const TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF9A31C9)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF9A31C9), width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF9A31C9), width: 1),
    ),
    labelStyle: TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: Color(0xFF767474),
    ),
  );
}