import 'package:flutter/material.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Expanded(child: Divider(color: Color(0xFF767474), thickness: 1)),
          SizedBox(width: 5),
          Text(
            'Já possui uma conta?',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 0, 0, 0),
              wordSpacing: -0.3,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Padding(
                padding: EdgeInsetsGeometry.all(4),
                child: Text(
                  'Logar',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9A31C9),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF9A31C9),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(child: Divider(color: Color(0xFF767474), thickness: 1)),
        ],
      ),
    );
  }
}