import 'package:flutter/material.dart';

class CustomWhiteButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Size? minimumSize;

  const CustomWhiteButton({super.key,
  required this.label,
  required this.onPressed,
  this.minimumSize,});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF9A31C9),
                      side: BorderSide(color: Color(0xFF9A31C9), width: 1.5),
                      minimumSize: minimumSize ?? const Size(175, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
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