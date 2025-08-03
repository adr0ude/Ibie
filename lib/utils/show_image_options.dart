import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_white_button.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_green_button.dart';

Future<void> showImageOptions({
  required BuildContext context, 
  required VoidCallback onCamera, 
  required VoidCallback onGallery, 
  required VoidCallback onDelete}) async {
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
              'Escolha a foto para seu perfil:',
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
                label: 'Tirar Foto',
                onPressed: () {
                  Navigator.pop(context);
                  onCamera();
                },
                size: Size(354, 52),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: CustomGreenButton(
                label: 'Escolher Foto',
                onPressed: () {
                  Navigator.pop(context);
                  onGallery();
                },
                size: Size(354, 52),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: CustomWhiteButton(
                label: 'Remover Foto Atual',
                onPressed: () {
                  Navigator.pop(context);
                  onDelete();
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