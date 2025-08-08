import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'package:ibie/ui/widgets/custom_white_button.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_dropdown.dart';
import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/list_acessibility.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/ui/widgets/progress_bar.dart';

import 'package:ibie/ui/activity_form/activity_form_viewmodel.dart';

class ActivityFormResourcesPage extends StatefulWidget {
  const ActivityFormResourcesPage({super.key, required this.viewModel});

  final ActivityFormViewModel viewModel;

  @override
  State<ActivityFormResourcesPage> createState() =>
      _ActivityFormResourcesPagePageState();
}

class _ActivityFormResourcesPagePageState
    extends State<ActivityFormResourcesPage> {
  late final ActivityFormViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: 'Cadastro de Nova Atividade',
        onBack: () {
          viewModel.goToPreviousPage();
          Navigator.pop(context);
        },
      ),

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
                  'Preencha os campos abaixo:',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: 27),
                Center(
                  child: Text(
                    'Acessibilidade e Inclusão',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF71A151),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown<String>(
                          value:
                              listAcessibility.contains(
                                viewModel.selectedAccessibility,
                              )
                              ? viewModel.selectedAccessibility
                              : null,
                          label: "Recursos de Acessibilidade",
                          items: listAcessibility,
                          onChanged: (value) {
                            setState(() {
                              viewModel.accessibilityResources = value!;
                              state.didChange(value);
                            });
                          },
                        ),
                        SizedBox(height: 29),
                        if (viewModel.selectedAccessibility == 'Outros')
                          SizedBox(
                            width: 365,
                            child: TextFormField(
                              //controller: _cpfController,
                              onChanged: (value) =>
                                  viewModel.description = value,
                              maxLength: 200,
                              minLines: 1,
                              maxLines: 6,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: decorationForm("Descrição *"),
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black.withAlpha(178),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe a descrição do recurso de acessibilidade.';
                                } else if (value.length > 500) {
                                  return 'A descrição excede o limite de caracteres.';
                                }
                                return null;
                              },
                            ),
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
                SizedBox(height: 27),
                Center(
                  child: Column(
                    children: [
                      // Título
                      Text(
                        'Upload de Imagens da Atividade',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF71A151),
                        ),
                      ),
                      SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          /*
                          SvgPicture.asset(
                            'assets/images/upload.svg',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          */

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 32,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                // Texto principal
                                Text.rich(
                                  TextSpan(
                                    text: 'Envie ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Comfortaa',
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'arquivos ',
                                        style: TextStyle(
                                          color: Color(0xFF71A151),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'relevantes para a atividade.',
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 10),

                                Text(
                                  'Selecione .jpg ou .png',
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 14,
                                    color: Color(0xFF6D6D6D),
                                  ),
                                ),

                                SizedBox(height: 25),

                                // Botão de selecionar arquivo
                                ElevatedButton(
                                  onPressed: () {
                                    // por enquanto, só visual
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF71A151),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    'Selecionar arquivo',
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),

                Align(alignment: Alignment.centerLeft),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWhiteButton(
                      label: 'Cancelar',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      size: Size(175, 40),
                    ),
                    CustomPurpleButton(
                      label: 'Registrar',
                      onPressed: () async {
                        final result = await viewModel.submitForm();
                        switch (result) {
                          case Ok():
                            Navigator.pushReplacementNamed(context, '/home');
                          case Error():
                            showErrorMessage(context, result.errorMessage);
                        }
                      },
                      size: Size(175, 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ProgressBar(
        currentStep: viewModel.currentPage,
        totalSteps: 3,
      ),
    );
  }
}