import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';
import 'package:ibie/utils/show_sign_up_options.dart';

import 'package:ibie/ui/auth/view_model/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.viewModel});

  final LoginViewmodel viewModel;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: 'Login',
        onBack: () {
          Navigator.pushReplacementNamed(context, '/welcome');
        },
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(top: 78, bottom: 80),
              child: Center(
                child: Container(
                  height: 187,
                  width: 382,
                  color: Color(0xFFF4F5F9),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Positioned(
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/ibie.svg',
                          width: 240,
                          fit: BoxFit.contain,
                        ),
                      ),

                      Positioned(
                        left: 175,
                        child: SvgPicture.asset(
                          'assets/treeIpe.svg',
                          width: 188,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 18),
                    child: SizedBox(
                      width: 365,
                      child: TextFormField(
                        maxLength: 256,
                        buildCounter:
                            (
                              BuildContext context, {
                              required int currentLength,
                              required bool isFocused,
                              required int? maxLength,
                            }) {
                              return SizedBox.shrink();
                            },
                        onChanged: (value) => viewModel.email = value,
                        decoration: decorationForm("E-mail *"),
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withAlpha(178),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe seu e-mail';
                          } else if (value.length > 256) {
                            return "O e-mail excede o limite de caracteres";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 365,
                    child: TextFormField(
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
                          return 'Informe sua senha';
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
                ],
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 16,
                  right: 18,
                  bottom: 27,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: !viewModel.isLoading
                        ? () {
                            if (viewModel.email.isEmpty) {
                              showErrorMessage(context, 'Informe um e-mail');
                            } else {
                              showPopUp(
                                context: context,
                                title: 'Redefinir senha',
                                text:
                                    'Deseja receber um email para redefinição de senha?',
                                onPressed: () async {
                                  final result = await viewModel.sendEmail();
                                  switch (result) {
                                    case Ok():
                                      Navigator.pop(context);
                                      showOkMessage(context, 'E-mail enviado');
                                    case Error():
                                      showErrorMessage(
                                        context,
                                        result.errorMessage,
                                      );
                                  }
                                },
                              );
                            }
                          }
                        : null,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        'Esqueceu a senha?',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            CustomPurpleButton(
              label: 'Entrar',
              onPressed: !viewModel.isLoading
                  ? () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await viewModel.loginEmail();
                        switch (result) {
                          case Ok():
                            Navigator.pushReplacementNamed(context, '/home');
                          case Error():
                            showErrorMessage(context, result.errorMessage);
                        }
                      }
                    }
                  : null,
              size: Size(354, 52),
            ),
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(color: Color(0xFF767474), thickness: 1),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Ainda não possui uma conta?',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 0, 0),
                      wordSpacing: -0.3,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showSignUpOptions(context: context);
                      },
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(4),
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9A31C9),
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xFF9A31C9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Divider(color: Color(0xFF767474), thickness: 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
