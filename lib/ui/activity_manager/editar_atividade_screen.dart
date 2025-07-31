// lib/ui/activity_manager/editar_atividade_screen.dart

import 'package:flutter/material.dart';
import 'package:ibie/models/atividades_cards.dart';

class EditarAtividadeScreen extends StatefulWidget {
  final Atividade atividade;
  final String instructorName;

  const EditarAtividadeScreen({
    super.key,
    required this.atividade,
    required this.instructorName,
  });

  @override
  State<EditarAtividadeScreen> createState() => _EditarAtividadeScreenState();
}

class _EditarAtividadeScreenState extends State<EditarAtividadeScreen> {
  final PageController _pageController = PageController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _publicoAlvoController;
  late TextEditingController _numeroVagasController;
  late TextEditingController _valorInscricaoController;

  String? _selectedCategory;
  final List<String> _categories = [
    'Dança',
    'Artesanato',
    'Música',
    'Esporte',
    'Outros',
  ];

  late TextEditingController _dataController;
  late TextEditingController _horarioController;
  late TextEditingController _localNomeController;
  late TextEditingController _ruaController;
  late TextEditingController _numeroController;
  late TextEditingController _bairroController;
  late TextEditingController _cepController;

  String? _selectedCity;
  final List<String> _cities = ['Fortaleza', 'Tianguá', 'Ubajara', 'Sobral'];

  String? _selectedAccessibility;
  final List<String> _accessibilityOptions = [
    'Acesso para cadeirantes',
    'Audiodescrição',
    'Intérprete de Libras',
    'Nenhum',
  ];

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(
      text: widget.atividade.titulo.replaceAll('\n', ' '),
    );
    _descricaoController = TextEditingController(
      text:
          'O curso de Ballet Clássico - Iniciante é voltado para quem deseja dar os primeiros passos nessa arte elegante e disciplinada. Ao longo dos aulas, os alunos aprenderão fundamentos técnicos do ballet, consciência corporal, postura, musicalidade e expressão artística.',
    );
    _publicoAlvoController = TextEditingController(text: '8 - 16 anos');
    _numeroVagasController = TextEditingController(text: '30');
    _valorInscricaoController = TextEditingController(
      text: widget.atividade.preco,
    );

    _selectedCategory = widget.atividade.categoria;

    _dataController = TextEditingController(text: '15/08/2025');
    _horarioController = TextEditingController(text: '15:00');
    _localNomeController = TextEditingController(text: 'Escola Azul');
    _ruaController = TextEditingController(text: 'Rua 13 de Maio');
    _numeroController = TextEditingController(text: '1');
    _bairroController = TextEditingController(text: 'Centro');
    _cepController = TextEditingController(text: '62350-000');
    _selectedCity = 'Ubajara';

    _selectedAccessibility = _accessibilityOptions[0];
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _publicoAlvoController.dispose();
    _numeroVagasController.dispose();
    _valorInscricaoController.dispose();
    _dataController.dispose();
    _horarioController.dispose();
    _localNomeController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _cepController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildCustomTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF9A31C9)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF9A31C9), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF71A151), width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      style: const TextStyle(fontSize: 16),
      cursorColor: const Color(0xFF71A151),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Editar Atividades'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preencha os campos abaixo:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Informações da Atividade',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF71A151),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _tituloController,
                    labelText: 'Título da Atividade',
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _descricaoController,
                    labelText: 'Descrição',
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      labelStyle: const TextStyle(color: Color(0xFF9A31C9)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF9A31C9),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF71A151),
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    iconEnabledColor: const Color(0xFF9A31C9),
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _publicoAlvoController,
                    labelText: 'Público-Alvo',
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _numeroVagasController,
                    labelText: 'Número de Vagas',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _valorInscricaoController,
                    labelText: 'Valor da Inscrição',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF9A31C9),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9A31C9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9A31C9),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Próximo',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF71A151),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ETAPA 2: Data e Local
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preencha os campos abaixo:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Data e Local',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF71A151),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _dataController,
                    labelText: 'Data',
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF71A151),
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        _dataController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _horarioController,
                    labelText: 'Horário',
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF71A151),
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedTime != null) {
                        _horarioController.text = pickedTime.format(context);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _localNomeController,
                    labelText: 'Local',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Endereço',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF71A151),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _ruaController,
                    labelText: 'Rua',
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _numeroController,
                    labelText: 'Número',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _bairroController,
                    labelText: 'Bairro',
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                      labelStyle: const TextStyle(color: Color(0xFF9A31C9)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF9A31C9),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF71A151),
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    items: _cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCity = newValue;
                      });
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    iconEnabledColor: const Color(0xFF9A31C9),
                  ),
                  const SizedBox(height: 15),
                  _buildCustomTextFormField(
                    controller: _cepController,
                    labelText: 'CEP',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF9A31C9),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Anterior',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9A31C9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey2.currentState!.validate()) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9A31C9),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Próximo',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 2 / 3, // Etapa 2 de 3
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF71A151),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ETAPA 3: Acessibilidade e Inclusão
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preencha os campos abaixo:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Acessibilidade e Inclusão',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF71A151),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: _selectedAccessibility,
                    decoration: InputDecoration(
                      labelText: 'Recursos de Acessibilidade',
                      labelStyle: const TextStyle(color: Color(0xFF9A31C9)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF9A31C9),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xFF71A151),
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    items: _accessibilityOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAccessibility = newValue;
                      });
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    iconEnabledColor: const Color(0xFF9A31C9),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Upload de Imagens da Atividade',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF71A151),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFF3CEED),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Envie arquivos relevantes para o evento, como folders, imagens de divulgação e materiais complementares',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Selecione .jpg, .png ou .pdf',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            print('Selecionar arquivo clicado!');
                            // Lógica para selecionar arquivo
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF71A151), // Verde
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Selecionar arquivo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF9A31C9),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Anterior',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF9A31C9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey3.currentState!.validate()) {
                              // Lógica para SALVAR todas as informações do formulário
                              print('Salvar clicado!');
                              print('Título: ${_tituloController.text}');
                              print('Descrição: ${_descricaoController.text}');
                              print('Categoria: $_selectedCategory');
                              print(
                                'Público-Alvo: ${_publicoAlvoController.text}',
                              );
                              print('Vagas: ${_numeroVagasController.text}');
                              print('Valor: ${_valorInscricaoController.text}');
                              print('Data: ${_dataController.text}');
                              print('Horário: ${_horarioController.text}');
                              print('Local Nome: ${_localNomeController.text}');
                              print('Rua: ${_ruaController.text}');
                              print('Número: ${_numeroController.text}');
                              print('Bairro: ${_bairroController.text}');
                              print('CEP: ${_cepController.text}');
                              print('Cidade: $_selectedCity');
                              print('Acessibilidade: $_selectedAccessibility');

                              // --- ADICIONANDO A CONFIRMAÇÃO AQUI ---
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Atividade salva com sucesso!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Color(
                                    0xFF71A151,
                                  ), // Cor verde
                                  duration: Duration(
                                    seconds: 2,
                                  ), // Tempo de exibição
                                ),
                              );
                              // ------------------------------------

                              // E então navegar de volta ou para uma tela de sucesso
                              // Um pequeno atraso para o SnackBar aparecer antes de voltar
                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.pop(context); // Volta após salvar
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF71A151,
                            ), // Verde para Salvar
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Salvar',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: 3 / 3, // Etapa 3 de 3
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF71A151),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
