import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';

class EmptyScreenInstructor extends StatelessWidget {
  const EmptyScreenInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 70),
          Text(
            'Não há atividades',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'para mostrar!',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 80),
          SvgPicture.asset('assets/empty_icon.svg', width: 285, height: 210.9),
          SizedBox(height: 80),
          Text(
            'Clique no botão abaixo',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
            ),
          ),
          Text(
            'para descobrir ou adicionar',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
            ),
          ),
          Text(
            'novas atividades.',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
            ),
          ),
          SizedBox(height: 70),
          CustomPurpleButton(
            label: 'Explorar novas atividades',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            size: Size(354, 52),
          ),
          SizedBox(height: 10),
          CustomWhiteButton(
            label: 'Adicionar atividade',
            isGreen: true,
            onPressed: () {
              Navigator.pushNamed(context, '/activityFormDetails');
            },
            size: Size(354, 52),
          ),
        ],
      ),
    );
  }
}