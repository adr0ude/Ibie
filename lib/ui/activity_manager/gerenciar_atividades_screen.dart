// lib/ui/activity_manager/gerenciar_atividades_screen.dart

import 'package:flutter/material.dart';
import 'package:ibie/models/atividades_cards.dart';
import 'package:ibie/ui/activity_manager/detalhes_atividade_screen.dart'; // Importa DetalhesAtividadeScreen
import 'package:ibie/ui/activity_manager/widgets/gerenciar_atividade_card.dart';

class GerenciarAtividadesScreen extends StatelessWidget {
  const GerenciarAtividadesScreen({super.key});

  static final List<Map<String, dynamic>> atividadesInscritasData = [
    {
      'atividade': Atividade(
        categoria: 'Artesanato',
        titulo: 'Curso de\nCostura Criativa',
        professor: 'Prof. Maria',
        dataHora: '29/08/2025 | 10:00',
        local: 'Ateliê da Costura',
        imagemUrl:
            'https://img.freepik.com/free-photo/adorable-black-pug-dog-sitting-floor_181624-43642.jpg?t=st=1722306060000&exp=1722309660000&id=sid=328695029&w=1380',
        preco: 'R\$80,00',
      ),
      'instructorNameForDetails': 'Professora Maria',
    },
  ];

  static final List<Map<String, dynamic>> atividadesGerenciadasData = [
    {
      'atividade': Atividade(
        categoria: 'Dança',
        titulo: 'Curso de\nBallet Clássico',
        professor: '13 Inscritos',
        dataHora: '15/08/2025 | 16:00',
        local: 'Rua 13 de maio, Nº 141 Centro, Tianguá - CE',
        imagemUrl:
            'https://img.freepik.com/free-photo/red-ribbon-gift-box_1232-243.jpg?w=1380&t=st=1722363717000&exp=1722367317000&id=sid=328695029&w=1380',
        preco: 'R\$50,00',
      ),
      'instructorNameForDetails': 'Professora Maria Luiza',
    },
    {
      'atividade': Atividade(
        categoria: 'Dança',
        titulo: 'Ballet\nAvançado',
        professor: '20 Inscritos',
        dataHora: '20/09/2025 | 18:00',
        local: 'Teatro Municipal',
        imagemUrl:
            'https://img.freepik.com/free-photo/milk-splash-set_1085-797.jpg?w=1380&t=st=1722363749000&exp=1722367349000&id=sid=328695029&w=1380',
        preco: 'R\$70,00',
      ),
      'instructorNameForDetails': 'Professor João Silva',
    },
    {
      'atividade': Atividade(
        categoria: 'Dança',
        titulo: 'Ballet\nInfantil',
        professor: '2 Inscritos',
        dataHora: '10/08/2025 | 09:00',
        local: 'Academia Kids',
        imagemUrl:
            'https://img.freepik.com/free-photo/monstera-deliciosa-leaves-white-background_53876-133527.jpg?w=1380&t=st=1722363777000&exp=1722367377000&id=sid=328695029&w=1380',
        preco: 'R\$30,00',
      ),
      'instructorNameForDetails': 'Professora Ana Paula',
    },
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
        title: const Text('Gerenciar Atividades'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Atividades Inscritas',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF9A31C9),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: atividadesInscritasData.map((data) {
                final atividade = data['atividade'] as Atividade;
                final instructorName =
                    data['instructorNameForDetails'] as String;

                String statusParaCard;
                String cleanTitle = atividade.titulo.replaceAll('\n', ' ');
                if (cleanTitle.contains('Costura Criativa')) {
                  statusParaCard = 'CONCLUÍDA';
                } else {
                  statusParaCard = 'N/A';
                }

                return GerenciarAtividadeCard(
                  atividade: atividade,
                  onCardTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesAtividadeScreen(
                          atividade: atividade,
                          instructorName: instructorName,
                          activityStatus:
                              statusParaCard, // <--- PASSA O STATUS AQUI!
                        ),
                      ),
                    );
                  },
                  cardStatusText: statusParaCard,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            const Text(
              'Gerenciar Atividades',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xFF9A31C9),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: atividadesGerenciadasData.map((data) {
                final atividade = data['atividade'] as Atividade;
                final instructorName =
                    data['instructorNameForDetails'] as String;

                String statusParaCard;
                String cleanTitle = atividade.titulo.replaceAll('\n', ' ');
                if (cleanTitle.contains('Ballet Clássico')) {
                  statusParaCard = 'ATIVA';
                } else if (cleanTitle.contains('Ballet Avançado')) {
                  statusParaCard = 'CONCLUÍDA';
                } else if (cleanTitle.contains('Ballet Infantil')) {
                  statusParaCard = 'DESATIVADO';
                } else {
                  statusParaCard = 'N/A';
                }

                return GerenciarAtividadeCard(
                  atividade: atividade,
                  onCardTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesAtividadeScreen(
                          atividade: atividade,
                          instructorName: instructorName,
                          activityStatus:
                              statusParaCard, // <--- PASSA O STATUS AQUI!
                        ),
                      ),
                    );
                  },
                  cardStatusText: statusParaCard,
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  print('Adicionar Atividade clicado!');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF71A151), width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Adicionar Atividade',
                  style: TextStyle(fontSize: 18, color: Color(0xFF71A151)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
