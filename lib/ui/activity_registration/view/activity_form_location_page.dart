import 'package:flutter/material.dart';
import 'package:ibie/config/routes.dart';

import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_dropdown.dart';
import 'package:ibie/ui/widgets/progress_bar.dart';
import 'package:ibie/utils/form_decoration.dart';
import 'package:ibie/utils/list_cities.dart';
import 'package:ibie/utils/input_formatters.dart';
import 'package:ibie/utils/show_pop_up.dart';

import 'package:ibie/ui/activity_registration/activity_form_viewmodel.dart';

class ActivityFormLocationPage extends StatefulWidget {
  const ActivityFormLocationPage({
    super.key,
    required this.viewModel,
    this.isEditing = false,
  });

  final ActivityFormViewmodel viewModel;
  final bool isEditing;

  @override
  State<ActivityFormLocationPage> createState() =>
      _ActivityFormLocationPageState();
}

class _ActivityFormLocationPageState extends State<ActivityFormLocationPage> {
  late final ActivityFormViewmodel viewModel;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    if (widget.isEditing) {
      _initEditing();
    }
  }

  Future<void> _initEditing() async {
    _dateController.text = viewModel.date;
    _timeController.text = viewModel.time;
    _locationController.text = viewModel.location;
    _streetController.text = viewModel.street;
    _numberController.text = viewModel.number;
    _neighborhoodController.text = viewModel.neighborhood;
    _cepController.text = viewModel.cep;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: widget.isEditing
            ? 'Editar Atividade'
            : 'Cadastro de Nova Atividade',
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
                    'Data e Local',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF71A151),
                    ),
                  ),
                ),
                SizedBox(height: 22),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _dateController,
                    inputFormatters: [dateFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: decorationForm("Data *"),
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.dateEditing = value;
                      } else {
                        viewModel.date = value;
                      }
                    },
                    validator: (value) => viewModel.validateDate(value ?? ''),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _timeController,
                    inputFormatters: [timeFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: decorationForm("Horário *"),
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.timeEditing = value;
                      } else {
                        viewModel.time = value;
                      }
                    },
                    validator: (value) => viewModel.validateTime(value ?? ''),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _locationController,
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.locationEditing = value;
                      } else {
                        viewModel.location = value;
                      }
                    },
                    decoration: decorationForm("Local *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o local';
                      } else if (value.length > 100) {
                        return 'O local excede o limite de caracteres';
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
                SizedBox(height: 22),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _streetController,
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.streetEditing = value;
                      } else {
                        viewModel.street = value;
                      }
                    },
                    decoration: decorationForm("Rua *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a rua';
                      } else if (value.length > 100) {
                        return 'A rua excede o limite de caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _numberController,
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.numberEditing = value;
                      } else {
                        viewModel.number = value;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationForm("Número"),
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
                      if (number < 0) {
                        return 'O número deve ser positivo.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _neighborhoodController,
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.neighborhoodEditing = value;
                      } else {
                        viewModel.neighborhood = value;
                      }
                    },
                    decoration: decorationForm("Bairro *"),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o bairro da atividade';
                      } else if (value.length > 50) {
                        return 'O bairro excede o limite de caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),

                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown<String>(
                          value: listCities.contains(viewModel.selectedCity)
                              ? viewModel.selectedCity
                              : null,
                          label: "Cidade *",
                          items: listCities,
                          onChanged: (value) {
                            setState(() {
                              if (widget.isEditing) {
                                viewModel.cityEditing = value!;
                                viewModel.city = value;
                              } else {
                                viewModel.city = value!;
                              }
                              state.didChange(value);
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Informe a cidade' : null,
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
                SizedBox(height: 20),
                SizedBox(
                  width: 365,
                  child: TextFormField(
                    controller: _cepController,
                    inputFormatters: [cepFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: decorationForm("CEP *"),
                    onChanged: (value) {
                      if (widget.isEditing) {
                        viewModel.cepEditing = value;
                      } else {
                        viewModel.cep = value;
                      }
                    },
                    validator: (value) => viewModel.validateCep(value ?? ''),
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.black.withAlpha(178),
                    ),
                  ),
                ),
                Align(alignment: Alignment.centerLeft),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWhiteButton(
                      label: 'Cancelar',
                      onPressed: () {
                        if (widget.isEditing) {
                          showPopUp(
                            context: context,
                            title: 'Cancelar Edição',
                            text:
                                'Os dados preenchidos não serão salvos. Deseja realmente cancelar esta operação?',
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                            },
                          );
                        } else {
                          showPopUp(
                            context: context,
                            title: 'Cancelar Cadastro',
                            text:
                                'Os dados preenchidos não serão salvos. Deseja realmente cancelar esta operação?',
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                            },
                          );
                        }
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
                            '/activityFormResources',
                            arguments: ActivityFormResourcesArgs(
                              viewModel: viewModel,
                              isEditing: widget.isEditing,
                            ),
                          );
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
