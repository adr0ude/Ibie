import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projetoteste/widgets/barraApp.dart';
import 'package:projetoteste/widgets/botaoBranco.dart';
import 'package:projetoteste/widgets/botaoRoxo.dart';
import 'package:projetoteste/widgets/loginPrompt.dart';

class CadastrarFotoInstrutor extends StatefulWidget {
  const CadastrarFotoInstrutor({super.key});

  @override
  State<CadastrarFotoInstrutor> createState() => _CadastrarFotoInstrutorState();
}

class _CadastrarFotoInstrutorState extends State<CadastrarFotoInstrutor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: 'Cadastro de Conta',
        showSkip: true,
        onSkip: (){},
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Text(
              'Insira uma foto de perfil:',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 125),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 283,
                    height: 283,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF71A151)),
                    ),
                    child: SvgPicture.asset(
                      'assets/perfil.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 7,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF71A151),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 140),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomWhiteButton(label: 'Cancelar', onPressed: () {}),
                CustomPurpleButton(label: 'Próximo', onPressed: () {}),
              ],
            ),

            SizedBox(height: 28),
            Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned.fill(
                    child: Center(
                      child: Container(height: 5, color: Color(0xFF71A151)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF71A151),
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFD9D9D9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            SizedBox(height: 18),
            LoginPrompt(onLoginTap: () {}),
          ],
        ),
      ),
    );
  }
}
