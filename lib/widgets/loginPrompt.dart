import 'package:flutter/material.dart';

class LoginPrompt extends StatelessWidget {
  final VoidCallback onLoginTap;

  const LoginPrompt({super.key, required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Expanded(child: Divider(color: Color(0xFF767474), thickness: 1)),
          Text(
            'Já possui uma conta?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 0, 0, 0),
              wordSpacing: -0.3,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onLoginTap,
              child: Padding(
                padding: EdgeInsetsGeometry.all(4),
                child: Text(
                  'Logar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF71A151),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Divider(color: Color(0xFF767474), thickness: 1)),
        ],
      ),
    );
  }
}
