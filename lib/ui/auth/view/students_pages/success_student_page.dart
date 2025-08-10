import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';

class SuccessStudentPage extends StatelessWidget {
  const SuccessStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBEEF8),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 85),
              Text(
                'Cadastro\nrealizado com\nsucesso!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
        
              SizedBox(height: 65,),
              SvgPicture.asset('assets/ibieSucesso.svg',
              width: 326,
              height: 255,
              ),
        
              SizedBox(height: 65,),
              Text(
                textAlign: TextAlign.center,
                'Você já pode explorar todos os\nrecursos disponíveis no Ibiê!\n\nDescubra atividades culturais,\nrecreativas e formativas,\npersonalize sua experiência e\nparticipe dos eventos que mais\ncombinam com você.',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
                letterSpacing: 0.1,
                wordSpacing: 0.1,
                height: 1.15,
              ),
              ),
        
              SizedBox(height: 50,),
              CustomPurpleButton(
                label: 'Acessar', 
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/home');
                }, 
                size: Size(354, 52),
              ),
            ],
          ),
        ),
      ),
    );
  }
}