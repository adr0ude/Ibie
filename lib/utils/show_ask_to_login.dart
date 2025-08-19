import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/buttons/custom_green_button.dart';

Future<void> showAskToLogin({required BuildContext context}) async {
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
              'Acesso restrito',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: CustomGreenButton(
                label: 'Entrar com minha conta',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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