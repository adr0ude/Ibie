import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_profile_avatar.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/login_prompt.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

import 'package:ibie/ui/auth/view_model/register_instructor_viewmodel.dart';

class RegisterInstructorPhotoPage extends StatefulWidget {
  const RegisterInstructorPhotoPage({super.key, required this.viewModel});

  final RegisterInstructorViewmodel viewModel;

  @override
  State<RegisterInstructorPhotoPage> createState() =>
      _RegisterInstructorPhotoPageState();
}

class _RegisterInstructorPhotoPageState extends State<RegisterInstructorPhotoPage> {
  late final RegisterInstructorViewmodel viewModel;

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
        onSkip: () {
          Navigator.pushReplacementNamed(context, '/successInstructor');
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
              ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return CustomProfileAvatar(
                    photo: viewModel.photo,
                    onCamera: () async => await viewModel.pickImage('camera'),
                    onGallery: () async => await viewModel.pickImage('gallery'),
                    onDelete: () => viewModel.photo = '',
                    size: 300,
                    svgSize: 230,
                  );
                },
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
                    size: Size(175, 40),
                  ),
                  CustomPurpleButton(
                    label: 'Registrar',
                    onPressed: !viewModel.isLoading
                      ? () async {
                        final result = await viewModel.signUpEmail();
                        switch (result) {
                          case Ok():
                            Navigator.pushReplacementNamed(context, '/successInstructor');
                          case Error():
                            showErrorMessage(context, result.errorMessage);
                        }
                      }
                      : null,
                    size: Size(175, 40),
                  ),
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
              LoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
