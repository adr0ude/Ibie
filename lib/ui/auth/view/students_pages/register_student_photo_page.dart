import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_white_button.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/login_prompt.dart';
import 'package:ibie/utils/show_image_options.dart';

import 'package:ibie/ui/auth/viewModel/register_student_viewmodel.dart';

class RegisterStudentPhotoPage extends StatefulWidget {
  const RegisterStudentPhotoPage({super.key, required this.viewModel});

  final RegisterStudentViewmodel viewModel;

  @override
  State<RegisterStudentPhotoPage> createState() => _RegisterStudentPhotoPageState();
}

class _RegisterStudentPhotoPageState extends State<RegisterStudentPhotoPage> {
  late final RegisterStudentViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: 'Cadastro de Conta',
        showSkip: true,
        onSkip: (){
          Navigator.pushNamed(context, '/preferences', arguments: widget.viewModel);
        },
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Insira uma foto de perfil:',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
        
              SizedBox(height: 140),
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
                        color: Color(0xFFFFFFFF),
                      ),
                      child: SvgPicture.asset(
                        'assets/perfil.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 7,
                      child: GestureDetector(
                        onTap: () {
                          showImageOptions(context: context);
                        },
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
                  CustomWhiteButton(
                    label: 'Cancelar', 
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    }, 
                    size: Size(175,40)
                  ),
                  CustomPurpleButton(
                    label: 'Próximo', 
                    onPressed: () {
                      Navigator.pushNamed(context, '/preferences', arguments: widget.viewModel);
                    }, 
                    size: Size(175,40),
                  ),
                ],
              ),
        
              SizedBox(height: 28),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned.fill(
                    child: Center(
                      child: SizedBox(
                        height: 5,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(child: Container(color: Color(0xFF71A151))),
                            Expanded(child: Container(color: Color(0xFFD9D9D9))),
                          ],
                        ),
                      ),
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
              LoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}