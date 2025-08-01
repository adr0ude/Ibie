// lib/ui/activity_manager/ver_detalhes_activity_screen.dart

import 'package:flutter/material.dart';
import 'package:ibie/models/atividades_cards.dart';

class VerDetalhesActivityScreen extends StatelessWidget {
  final Atividade atividade;
  final String instructorName;

  const VerDetalhesActivityScreen({
    super.key,
    required this.atividade,
    required this.instructorName,
  });

  // Dados mockados para a lista de alunos
  static final List<String> listaDeAlunos = const [
    'Lucas Pereira',
    'Júlia Santos',
    'Pedro Oliveira',
    'Mariana Costa',
    'Gabriel Silva',
    'Beatriz Ferreira',
    'Matheus Souza',
    'Camila Lima',
    'Rafael Rodrigues',
    'Amanda Gomes',
    'Bruno Alves',
    'Larissa Ribeiro',
    'Felipe Martins',
  ];

  // Dados mockados para os feedbacks
  static final List<String> feedbacks = const [
    'Ótima instrutora, boa didática e ótimo espaço.',
    'Aula muito animada, com coreografias criativas e um professor extremamente paciente.',
    'Turma acolhedora, conteúdo desafiador na medida certa e ambiente sempre limpo e organizado.',
  ];

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
        title: Text('Detalhes de ${atividade.titulo.replaceAll('\n', ' ')}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              atividade.imagemUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 70,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    atividade.titulo.replaceAll('\n', ' '),
                    style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    instructorName,
                    style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sobre a atividade',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3CEED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'O curso de Ballet Clássico - Iniciante é voltado para quem deseja dar os primeiros passos nessa arte elegante e disciplinada. Ao longo dos aulas, os alunos aprenderão fundamentos técnicos do ballet, consciência corporal, postura, musicalidade e expressão artística.',
                      style: TextStyle(fontFamily: 'Comfortaa', fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 30),
                  _buildInfoChip(
                    Icons.person,
                    '${listaDeAlunos.length} alunos inscritos',
                    const Color(0xFF71A151),
                    isFullWidth: true,
                    fontSize: 18,
                    paddingVertical: 15,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Lista de Inscritos',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF9A31C9),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFF3CEED),
                        width: 2,
                      ),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      itemCount: listaDeAlunos.length,
                      itemBuilder: (context, index) {
                        final aluno = listaDeAlunos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9A31C9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(aluno, style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Principais Feedbacks:',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF9A31C9),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Column(
                    children: feedbacks.map((feedback) {
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Color(0xFFF3CEED),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            feedback,
                            style: const TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String text,
    Color chipColor, {
    bool isFullWidth = false,
    double fontSize = 14,
    double paddingVertical = 8,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: paddingVertical),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: isFullWidth
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: chipColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: fontSize, color: chipColor),
          ),
        ],
      ),
    );
  }
}
