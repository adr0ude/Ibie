// lib/ui/activity_manager/detalhes_atividade_screen.dart

import 'package:flutter/material.dart';
import 'package:ibie/models/atividades_cards.dart';
import 'package:ibie/ui/activity_manager/ver_detalhes_activity_screen.dart';
import 'package:ibie/ui/activity_manager/editar_atividade_screen.dart'; // Certifique-se que este import existe

class DetalhesAtividadeScreen extends StatelessWidget {
  final Atividade atividade;
  final String instructorName;
  final String activityStatus; // <--- NOVO PARÂMETRO PARA O STATUS DA ATIVIDADE

  const DetalhesAtividadeScreen({
    super.key,
    required this.atividade,
    required this.instructorName,
    required this.activityStatus, // <--- ADICIONADO AO CONSTRUTOR
  });

  @override
  Widget build(BuildContext context) {
    // A função navigateToVerDetalhes agora depende do activityStatus para ser chamada
    void navigateToVerDetalhes() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerDetalhesActivityScreen(
            atividade: atividade,
            instructorName: instructorName,
            // Não precisa passar activityStatus para ver_detalhes, ela não usa botões
          ),
        ),
      );
    }

    // Condição para exibir os botões de ação
    final bool showActionButtons = activityStatus == 'ATIVA';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Detalhes da Atividade'),
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
                  const SizedBox(height: 20),

                  // WRAP DOS CHIPS CLICÁVEL (SEMPRE APARECE, MAS NÃO NAVEGA MAIS POR SI SÓ)
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildInfoChip(
                        Icons.calendar_today,
                        'Sexta-feira',
                        const Color(0xFF71A151),
                      ),
                      _buildInfoChip(
                        Icons.location_on,
                        'Escola Azul',
                        const Color(0xFF71A151),
                      ),
                      _buildInfoChip(
                        Icons.people,
                        '6 a 13 anos',
                        const Color(0xFF9A31C9),
                      ),
                      _buildInfoChip(
                        Icons.palette,
                        'Artístico',
                        const Color(0xFF9A31C9),
                      ),
                      _buildInfoChip(
                        Icons.attach_money,
                        atividade.preco,
                        const Color(0xFF9A31C9),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // RENDERIZA OS BOTÕES SOMENTE SE showActionButtons FOR TRUE
                  if (showActionButtons) ...[
                    _buildActionButton(
                      context,
                      'Ver detalhes',
                      const Color(0xFF9A31C9),
                      navigateToVerDetalhes, // Navega para VerDetalhesActivityScreen
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton(
                      context,
                      'Editar atividade',
                      const Color(0xFF71A151),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarAtividadeScreen(
                              atividade: atividade,
                              instructorName: instructorName,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton(
                      context,
                      'Remover atividade',
                      const Color(0xFF9A31C9),
                      () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text(
                                'Remover Atividade',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              content: Text(
                                'Você confirma a remoção da atividade ${atividade.titulo.replaceAll('\n', ' ')}?',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF9A31C9),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print(
                                            'Atividade "${atividade.titulo.replaceAll('\n', ' ')}" removida!',
                                          );
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Exclusão bem-sucedida',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              backgroundColor: const Color(
                                                0xFF71A151,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              margin: const EdgeInsets.only(
                                                bottom: 20,
                                                left: 16,
                                                right: 16,
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF9A31C9,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Confirmar',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      textColor: const Color(0xFF9A31C9),
                      isOutlined: true,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir os chips de informação
  Widget _buildInfoChip(IconData icon, String text, Color chipColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: chipColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: chipColor,
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para construir os botões de ação
  Widget _buildActionButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onPressed, {
    Color? textColor,
    bool isOutlined = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: color, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: textColor ?? color),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
    );
  }
}
