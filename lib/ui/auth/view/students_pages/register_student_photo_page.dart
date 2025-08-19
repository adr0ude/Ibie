import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_profile_avatar.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/login_prompt.dart';

import 'package:ibie/ui/auth/view_model/register_student_viewmodel.dart';
import 'package:ibie/utils/show_pop_up.dart';

class RegisterStudentPhotoPage extends StatefulWidget {
  const RegisterStudentPhotoPage({super.key, required this.viewModel});

  final RegisterStudentViewmodel viewModel;

  @override
  State<RegisterStudentPhotoPage> createState() =>
      _RegisterStudentPhotoPageState();
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
    final scaffoldContext = context;
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF4F5F9),
          appBar: CustomAppBar(
            title: 'Cadastro de Conta',
            showSkip: true,
            onSkip: () {
              Navigator.pushNamed(
                context,
                '/preferences',
                arguments: widget.viewModel,
              );
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
                        onCamera: () async =>
                            await viewModel.pickImage('camera'),
                        onGallery: () async =>
                            await viewModel.pickImage('gallery'),
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
                          showPopUp(
                            context: scaffoldContext,
                            title: "Cancelar cadastro",
                            text:
                                "Deseja realmente cancelar o cadastro? Todos os dados serão perdidos.",
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                scaffoldContext,
                                '/login',
                                (route) => false,
                              );
                            },
                          );
                        },
                        size: Size(175, 40),
                      ),
                      ListenableBuilder(
                        listenable: viewModel,
                        builder: (context, child) {
                          return CustomPurpleButton(
                            label: 'Próximo',
                            onPressed: !viewModel.isLoading
                                ? () {
                                    Navigator.pushNamed(
                                      scaffoldContext,
                                      '/preferences',
                                      arguments: widget.viewModel,
                                    );
                                  }
                                : null,
                            size: Size(175, 40),
                          );
                        },
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
                                Expanded(
                                  child: Container(color: Color(0xFF71A151)),
                                ),
                                Expanded(
                                  child: Container(color: Color(0xFFD9D9D9)),
                                ),
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
      },
    );
  }
}
