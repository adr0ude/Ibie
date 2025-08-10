import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/progress_bar.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_dropdown.dart';
import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/show_pop_up.dart';

import 'package:ibie/ui/activity_form/activity_form_viewmodel.dart';

class ActivityFormDetailsPage extends StatefulWidget {
  const ActivityFormDetailsPage({super.key, required this.viewModel});

  final ActivityFormViewModel viewModel;

  @override
  State<ActivityFormDetailsPage> createState() =>
      _ActivityFormDetailsPagePageState();
}

class _ActivityFormDetailsPagePageState extends State<ActivityFormDetailsPage> {
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
      appBar: CustomAppBar(title: 'Cadastro de Nova Atividade'),

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
                    'Informações da Atividade',
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
                    onChanged: (value) => viewModel.title = value,
                    maxLength: 100,
                    decoration: decorationForm("Título da Atividade *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o título da atividade.';
                      } else if (value.length > 100) {
                        return 'O título excede o limite de caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    onChanged: (value) => viewModel.description = value,
                    maxLength: 500,
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
                        return 'Informe a descrição da atividade.';
                      } else if (value.length > 500) {
                        return 'A descrição excede o limite de caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown<String>(
                          value: viewModel.selectedCategory.isNotEmpty
                              ? viewModel.selectedCategory
                              : null,
                          label: "Categoria *",
                          items: viewModel.availableCategories
                              .map((c) => c.name)
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              viewModel.category = value!;
                              state.didChange(value);
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Selecione uma categoria.' : null,
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
                    onChanged: (value) => viewModel.targetAudience = value,
                    maxLength: 100,
                    decoration: decorationForm("Público-Alvo"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value != null && value.length > 100) {
                        return 'O público-alvo excede o limite de caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: decorationForm("Número de Vagas"),
                    onChanged: (value) => viewModel.vacancies = value,
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }
                      final number = int.tryParse(value.trim());
                      if (number == null) {
                        return 'Informe um número válido.';
                      }
                      if (number <= 0) {
                        return 'O número de vagas deve ser maior que zero.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 29),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: decorationForm(
                      "Valor da Inscrição",
                    ).copyWith(prefixText: 'R\$ '),
                    onChanged: (value) {
                      final sanitized = value.trim().replaceAll(',', '.');
                      final number = double.tryParse(sanitized);

                      if (number != null && number == 0) {
                        viewModel.fee = "GRATUITO";
                      } else {
                        viewModel.fee = value;
                      }
                    },
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }

                      final sanitized = value.trim().replaceAll(',', '.');
                      final number = double.tryParse(sanitized);

                      if (number == null) {
                        return 'Informe um valor válido.';
                      }

                      if (number < 0) {
                        return 'O valor não pode ser negativo.';
                      }

                      return null; // Tudo certo
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
                        showPopUp(
                          context: context,
                          title: 'Cancelar Cadastro',
                          text:
                              'Os dados preenchidos não serão salvos. Deseja realmente cancelar esta operação?',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                        );
                      },
                      size: Size(175, 40),
                    ),
                    CustomPurpleButton(
                      label: 'Próximo',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.goToNextPage();
                          Navigator.pushNamed(
                            context,
                            '/activityFormLocation',
                            arguments: widget.viewModel,
                          );
                        }
                      },
                      size: Size(175, 40),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                SizedBox(height: 6),
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
