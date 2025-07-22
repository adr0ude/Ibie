import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_green_button.dart';

Future<void> showSignUpOptions({required BuildContext context}) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            const Text(
              'Cadastro de Conta',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: CustomPurpleButton(
                label: 'Cadastrar como cliente',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/registerStudent');
                },
                size: Size(354, 52),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: CustomGreenButton(
                label: 'Cadastrar como instrutor',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/registerInstructor');
                },
                size: Size(354, 52),
              ),
            ),
          ],
        ),
      );
    },
  );
}