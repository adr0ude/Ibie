import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 0.45 * altura,
                  width: double.infinity,
                  color: Color(0xFF9A31C9),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Image.asset(
                        'assets/ibie-branco.png',
                        height: 440,
                        width: 471,
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ),
        
                SvgPicture.asset(
                  'assets/Vector.svg',
                  height: 100,
                  fit: BoxFit.fill,
                ),
        
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 17),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bem-vindo ao Ibiê!',
                          style: TextStyle(
                            fontFamily: 'Walkingrush',
                            fontSize: 40,
                            color: Color(0xFF71A151),
                          ),
                        ),
        
                        SizedBox(height: 17),
        
                        Text(
                          'Descubra eventos culturais, \nartísticos, recreativos e formativos \nperto de você. \nEncontre, participe e conecte-se\n com o que você ama!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF71A151),
                          ),
                        ),
        
                        SizedBox(height: 38),
        
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF9A31C9),
                            foregroundColor: Color(0xFF9A31C9),
                            minimumSize: const Size(354, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Entrar na minha conta',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
        
                        SizedBox(height: 14),
        
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF9A31C9),
                            side: BorderSide(
                              color: Color(0xFF9A31C9),
                              width: 1.5,
                            ),
                            minimumSize: Size(354, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Entrar como visitante',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9A31C9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}