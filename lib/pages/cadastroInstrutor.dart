import 'package:flutter/material.dart';
import 'package:projetoteste/widgets/loginPrompt.dart';

class CadastroContaInstrutor extends StatefulWidget {
  const CadastroContaInstrutor({super.key});

  @override
  State<CadastroContaInstrutor> createState() => _CadastroContaInstrutorState();
}

class _CadastroContaInstrutorState extends State<CadastroContaInstrutor> {
  final _formKey = GlobalKey<FormState>();
  bool _mostrarSenha = false;
  String? _cidadeSelecionada;
  final List _cidades = [
    'Carnaubal',
    'Croatá',
    'Ibiapina',
    'Ipu',
    'São Benedito',
    'Tianguá',
    'Ubajara',
    'Viçosa do Ceará',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text(
          'Cadastro de Conta',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 4.0,
        shadowColor: Color.fromARGB(150, 0, 0, 0),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              _buildCampo("Nome Completo *"),
              _buildCampo("CPF *"),
              _buildCampo("Data de Nascimento *"),

              DropdownButtonFormField<String>(
                decoration: _inputDecoration("Cidade *"),
                value: _cidadeSelecionada,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _cidadeSelecionada = newValue;
                  });
                },
                items: _cidades.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              SizedBox(height: 16),
              _buildCampo("Número de Telefone *"),
              _buildCampo("E-mail *"),
              _buildCampo("Senha *"),

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
                        value: _mostrarSenha,
                        onChanged: (bool? value) {
                          setState(() {
                            _mostrarSenha = value ?? false;
                          });
                        },
                        side: BorderSide(color: Color(0xFF71A151)),
                        activeColor: Color(0xFF71A151),
                        visualDensity: VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Mostrar senha',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 12,
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
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF9A31C9),
                      side: BorderSide(color: Color(0xFF9A31C9), width: 1.5),
                      minimumSize: Size(175, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9A31C9),
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9A31C9),
                      foregroundColor: Color(0xFF9A31C9),
                      minimumSize: const Size(175, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Próximo ',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
              LoginPrompt(
                onLoginTap: (){}
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCampo(String label) {
  EdgeInsets paddingCampo = (label.toLowerCase() == "senha *")
      ? const EdgeInsets.only(bottom: 6)
      : const EdgeInsets.only(bottom: 16);

  return Padding(
    padding: paddingCampo,
    child: TextFormField(decoration: _inputDecoration(label)),
  );
}

InputDecoration _inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF9A31C9)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF9A31C9)),
    ),
    labelStyle: TextStyle(
      fontFamily: 'Comfortaa',
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: Color(0xFF767474),
    ),
  );
}
