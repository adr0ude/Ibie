import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_dropdown.dart';
import 'package:ibie/ui/widgets/login_prompt.dart';
import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/list_cities.dart';

import 'package:ibie/ui/auth/viewModel/register_instructor_viewmodel.dart';

class RegisterInstructorPage extends StatefulWidget {
  const RegisterInstructorPage({super.key, required this.viewModel});

  final RegisterInstructorViewmodel viewModel;

  @override
  State<RegisterInstructorPage> createState() => _RegisterInstructorPagePageState();
}

class _RegisterInstructorPagePageState extends State<RegisterInstructorPage> {
  late final RegisterInstructorViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  final _formKey = GlobalKey<FormState>();
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(title: 'Cadastro de Conta'),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Informe os dados abaixo:',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _nomeController,
                    onChanged: (value) => viewModel.name = value,
                    decoration: decorationForm("Nome Completo *"),
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
                SizedBox(height: 16),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _cpfController,
                    onChanged: (value) => viewModel.cpf = value,
                    decoration: decorationForm("CPF *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu CPF!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _nomeController,
                    onChanged: (value) => viewModel.dateBirth = value,
                    decoration: decorationForm("Data de Nascimento *"),
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
                          value: listCities.contains(viewModel.city) ? viewModel.city : null,
                          label: "Cidade *",
                          items: listCities,
                          onChanged: (value) {
                            setState(() {
                              viewModel.city = value!;
                              state.didChange(value);
                            });
                          },
                          validator: (value) => value == null ? 'Informe sua Cidade!' : null,
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
                    //controller: _phoneController,
                    onChanged: (value) => viewModel.phone = value,
                    decoration: decorationForm("Número de Telefone *"),
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
                    //controller: _emailController,
                    decoration: decorationForm("E-mail *"),
                    onChanged: (value) => viewModel.email = value,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu E-mail!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),

                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _passwordController,
                    onChanged: (value) => viewModel.password = value,
                    decoration: decorationForm("Senha *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    obscureText: _hidePass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe sua Senha!';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 6),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 140,
                    height: 18,
                    padding: EdgeInsetsGeometry.only(left: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: !_hidePass,
                          onChanged: (bool? value) {
                            setState(() {
                              _hidePass = !(value ?? false);
                            });
                          },
                          side: BorderSide(color: Color(0xFF71A151)),
                          activeColor: Color(0xFF71A151),
                          visualDensity: VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Mostrar senha',
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF767474),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 40),
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
                      label: 'Próximo',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/registerInstructorPhoto', arguments: widget.viewModel);
                        }
                      },
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
                        child: Container(height: 5, color: Color(0xFFD9D9D9)),
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
      ),
    );
  }
}
