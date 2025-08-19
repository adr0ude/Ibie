import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';

class EmptyScreenStudent extends StatelessWidget {
  const EmptyScreenStudent({super.key});

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
            'inscritas para mostrar!',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 130),
          SvgPicture.asset('assets/empty_icon.svg', width: 285, height: 210.9),
          SizedBox(height: 130),
          Text(
            'Clique no botão abaixo para',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF000000),
              fontFamily: 'Comfortaa',
            ),
          ),
          Text(
            'descobrir novas atividades.',
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
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
            size: Size(354, 52),
          ),
        ],
      ),
    );
  }
}