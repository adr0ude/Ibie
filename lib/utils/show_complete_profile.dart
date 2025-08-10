import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';

Future<void> showCompleteProfile({
  required BuildContext context,
  required VoidCallback onContinue,
}) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
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
              'Complete seu perfil',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Inclua uma minibiografia em seu perfil para apresentar-se melhor aos alunos.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Row(
                children: [
                  CustomWhiteButton(
                    label: 'Cancelar',
                    onPressed: () => Navigator.of(context).pop(),
                    size: Size(175, 40),
                  ),
                  SizedBox(width: 10),
                  CustomPurpleButton(
                    label: 'Confirmar',
                    onPressed: onContinue,
                    size: Size(175, 40),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
