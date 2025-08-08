import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_white_button.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_dropdown.dart';
import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/list_cities.dart';
import 'package:ibie/ui/widgets/progress_bar.dart';

import 'package:ibie/ui/activity_form/activity_form_viewmodel.dart';

class ActivityFormLocationPage extends StatefulWidget {
  const ActivityFormLocationPage({super.key, required this.viewModel});

  final ActivityFormViewModel viewModel;

  @override
  State<ActivityFormLocationPage> createState() => _ActivityFormLocationPagePageState();
}

class _ActivityFormLocationPagePageState
    extends State<ActivityFormLocationPage> {
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
          viewModel.goToPreviousPage(); // <-- Atualiza a barra de progresso
          Navigator.pop(context); // <-- Volta para a tela anterior
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
                    'Data e Local',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF71A151),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _nomeController,
                    onChanged: (value) => viewModel.title = value,
                    decoration: decorationForm("Data *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe uma data válida.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 29),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _cpfController,
                    onChanged: (value) => viewModel.description = value,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: decorationForm("Horário *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe um horário válido.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 29),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _nomeController,
                    onChanged: (value) => viewModel.title = value,
                    maxLength: 100,
                    decoration: decorationForm("Local *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o local.';
                      } else if (value.length > 100) {
                        return 'O local excede o limite de caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 27),
                Center(
                  child: Text(
                    'Endereço',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF71A151),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _cpfController,
                    onChanged: (value) => viewModel.description = value,
                    maxLength: 100,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: decorationForm("Rua *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a rua.';
                      } else if (value.length > 100) {
                        return 'A rua excede o limite de caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _cpfController,
                    onChanged: (value) => viewModel.description = value,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: decorationForm("Número"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                  ),
                ),
                SizedBox(height: 29),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _cpfController,
                    onChanged: (value) => viewModel.description = value,
                    maxLength: 50,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: decorationForm("Bairro *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o bairro da atividade.';
                      } else if (value.length > 50) {
                        return 'O bairro excede o limite de caracteres.';
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
                          label: "Cidade *",
                          items: listCities,
                          onChanged: (value) {
                            setState(() {
                              viewModel.city = value!;
                              state.didChange(value);
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Informe a cidade.' : null,
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
                SizedBox(height: 29),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    //controller: _nomeController,
                    onChanged: (value) => viewModel.targetAudience = value,
                    decoration: decorationForm("CEP *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value != null && value.length > 9) {
                        return 'Informe um CEP válido.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 6),

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
                      label: 'Próximo',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.goToNextPage();
                          Navigator.pushNamed(context, '/activityFormResources', arguments: widget.viewModel);
                        }
                      },
                      size: Size(175, 40),
                    ),
                  ],
                ),
                SizedBox(height: 30),
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
