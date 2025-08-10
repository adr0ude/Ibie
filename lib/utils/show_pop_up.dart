import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';

Future<void> showPopUp(
  {required BuildContext context,
  required String title,
  required String text,
  required VoidCallback onPressed,
  }
) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(0xFFFFFFFF),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  CustomWhiteButton(
                    label: 'Cancelar',
                    onPressed: () => Navigator.of(context).pop(),
                    size: Size(136, 40),
                  ),
                  SizedBox(width: 10),
                  CustomPurpleButton(
                    label: 'Confirmar',
                    onPressed: onPressed,
                    size: Size(136, 40),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}