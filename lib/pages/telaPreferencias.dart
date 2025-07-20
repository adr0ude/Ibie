import 'package:flutter/material.dart';
import 'package:projetoteste/widgets/barraApp.dart';
import 'package:projetoteste/widgets/botaoBranco.dart';
import 'package:projetoteste/widgets/botaoRoxo.dart';
import 'package:projetoteste/widgets/loginPrompt.dart';

class Categoria {
  final String nome;
  final IconData icone;

  Categoria(this.nome, this.icone);
}

class PreferenciasCadastro extends StatefulWidget {
  const PreferenciasCadastro({super.key});

  @override
  State<PreferenciasCadastro> createState() => _PreferenciasCadastroState();
}

class _PreferenciasCadastroState extends State<PreferenciasCadastro> {
  final List<Categoria> categorias = [
    Categoria('ESPORTES', Icons.directions_run),
    Categoria('MÚSICA', Icons.music_note),
    Categoria('CULTURA', Icons.emoji_emotions),
    Categoria('ARTES', Icons.brush),
    Categoria('EDUCAÇÃO', Icons.book),
    Categoria('RECREAÇÃO', Icons.nature_people),
  ];

  final Set<String> selecionadas = {};

  void toggleCategoria(String nome) {
    setState((){
      if (selecionadas.contains(nome)) {
        selecionadas.remove(nome);
      } else {
        selecionadas.add(nome);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cadastro de Conta',
        showSkip: true,
        onSkip: () {},
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            Text(
              'Adicione suas preferências:',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 40,),
            GridView.count(
              shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: NeverScrollableScrollPhysics(),
                children: categorias.asMap().entries.map((entry) {
                  final index = entry.key;
                  final categoria = entry.value;
                  final bool cores = true;
                  final bool ativa = selecionadas.contains(categoria.nome);
                  final Color cor = cores ? (index == 0 || index == 3 || index == 4 ? Color(0xFF9A31C9) : Color(0xFF71A151)) : Color(0xFFC3E29E);
                  final Color corContainer = ativa ? Color(0xFFC3E29E) : Color(0xFFFFFFFF);

                  return GestureDetector(
                    onTap: () => toggleCategoria(categoria.nome),
                    child: Container(
                      width: 194,
                      height: 170,
                      decoration: BoxDecoration(
                        color: corContainer,
                        border: Border.all(color: cor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: cor,
                            radius: 60,
                            child: Icon(categoria.icone, color: Colors.white, size: 60),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            categoria.nome,
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
            ),

            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              CustomWhiteButton(label: 'Cancelar', onPressed: () {}),
              CustomPurpleButton(label: 'Próximo', onPressed: () {})
            ],),

            SizedBox(height: 28),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned.fill(
                    child: Center(
                      child: Container(height: 5, color: Color(0xFF71A151)),
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
                          color: Color(0xFF71A151),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 18,),
              LoginPrompt(
                onLoginTap: (){}
              ),

              SizedBox(height: 28,),
          ],
        ),
      ),
    );
  }
}
