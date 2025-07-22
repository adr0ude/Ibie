import 'package:flutter/material.dart';

void showErrorMessage(context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          error,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Comfortaa',
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor: Color(0xFFE74C3C),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: 3),
    ),
  );
}