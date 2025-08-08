import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_dropdown.dart';
import 'package:ibie/ui/widgets/custom_profile_avatar.dart';
import 'package:ibie/ui/widgets/custom_white_button.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/pass_prompt.dart';
import 'package:ibie/ui/profile/profile_viewmodel.dart';

import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/list_cities.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.viewModel});

  final ProfileViewmodel viewModel;

  @override
  State<ProfilePage> createState() => _ProfilePagePageState();
}

class _ProfilePagePageState extends State<ProfilePage> {
  late final ProfileViewmodel viewModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    _init();
  }

  Future<void> _init() async {
    final result = await viewModel.init();
    switch (result) {
      case Ok():
        _nameController.text = viewModel.name;
        _biographyController.text = viewModel.biography;
        _dateController.text = viewModel.dateBirth;
        _phoneController.text = viewModel.phone;
        _cpfController.text = viewModel.cpf;
        _emailController.text = viewModel.email;
      case Error():
        if (mounted) {
          showErrorMessage(context, result.errorMessage);
        }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF4F5F9),
          appBar: CustomAppBar(
            title: 'Perfil',
            onBack: () => Navigator.pushReplacementNamed(context, '/home'),
          ),

          body: viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF9A31C9)),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(22),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          ListenableBuilder(
                            listenable: viewModel,
                            builder: (context, child) {
                              return CustomProfileAvatar(
                                photo: viewModel.newPhoto.isEmpty
                                    ? viewModel.photo
                                    : viewModel.newPhoto,
                                onCamera: () async =>
                                    await viewModel.pickImage('camera'),
                                onGallery: () async =>
                                    await viewModel.pickImage('gallery'),
                                onDelete: () => showPopUp(
                                  context: context,
                                  title: 'Remover foto de perfil',
                                  text: 'Deseja realmente remover sua foto de perfil?',
                                  onPressed: () async {
                                    final result = await viewModel
                                        .deletePhoto();
                                    switch (result) {
                                      case Ok():
                                        _init();
                                      case Error():
                                        showErrorMessage(context, result.errorMessage);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                                size: 230,
                                svgSize: 175,
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Dados Pessoais',
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 20,
                              color: Color(0xFF000000),
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: 365,
                            child: TextFormField(
                              controller: _nameController,
                              onChanged: (value) => viewModel.name = value,
                              decoration: decorationForm("Nome"),
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withAlpha(178),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu Nome Completo!';
                                }
                                return null;
                              },
                            ),
                          ),

                          if (viewModel.type == 'instructor') ...[
                            SizedBox(height: 15),
                            SizedBox(
                              width: 365,
                              child: TextFormField(
                                controller: _biographyController,
                                onChanged: (value) => viewModel.biography = value,
                                decoration: decorationForm(
                                  "Escreva uma mini biografia...",
                                  size: Size(365, 100),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black.withAlpha(178),
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 16),
                          SizedBox(
                            width: 365,
                            child: TextFormField(
                              controller: _dateController,
                              onChanged: (value) => viewModel.dateBirth = value,
                              decoration: decorationForm("Data de Nascimento"),
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withAlpha(178),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe sua Data de Nascimento!';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 16),

                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomDropdown<String>(
                                    value: listCities.contains(viewModel.city)
                                        ? viewModel.city
                                        : null,
                                    label: "Cidade",
                                    items: listCities,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.city = value!;
                                        state.didChange(value);
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Informe sua Cidade!'
                                        : null,
                                  ),
                                  if (state.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 6.0,
                                        left: 12.0,
                                      ),
                                      child: Text(
                                        state.errorText!,
                                        style: const TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 365,
                            child: TextFormField(
                              controller: _phoneController,
                              onChanged: (value) => viewModel.phone = value,
                              decoration: decorationForm("Telefone"),
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withAlpha(178),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu Número de Telefone!';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 16),

                          SizedBox(
                            width: 365,
                            child: TextFormField(
                              enabled: false,
                              controller: _emailController,
                              decoration: decorationForm(
                                "E-mail",
                                enabled: false,
                              ),
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withAlpha(178),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),

                          SizedBox(
                            width: 365,
                            child: TextFormField(
                              enabled: false,
                              controller: _cpfController,
                              decoration: decorationForm("CPF", enabled: false),
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withAlpha(178),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomWhiteButton(
                                label: 'Cancelar',
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                },
                                size: Size(175, 40),
                              ),
                              CustomPurpleButton(
                                label: 'Salvar',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    showPopUp(
                                      context: context,
                                      title: 'Salvar alterações',
                                      text: 'Deseja salvar as alterações?',
                                      onPressed: () async {
                                        final result = await viewModel
                                            .updateUserData();
                                        showOkMessage(
                                          context,
                                          'Alteração bem-sucedida',
                                        );
                                        switch (result) {
                                          case Ok():
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/home',
                                            );
                                          case Error():
                                            showErrorMessage(
                                              context,
                                              result.errorMessage,
                                            );
                                        }
                                      },
                                    );
                                  }
                                },
                                size: Size(175, 40),
                              ),
                            ],
                          ),

                          SizedBox(height: 18),
                          PassPrompt(viewModel: viewModel),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
