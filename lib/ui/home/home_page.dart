import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_drawer.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/ui/widgets/custom_cards.dart';
import 'package:ibie/models/atividades_cards.dart';

import 'package:ibie/ui/home/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Atividade> atividade = [
    Atividade(
      categoria: 'Artes',
      titulo: 'Curso de Ballet Clássico',
      professor: 'Maria Luiza',
      dataHora: '15/08/2025 | 16:00',
      local: 'Ubajara',
      imagemUrl:
          'https://offloadmedia.feverup.com/secretmedianetwork.com/wp-content/uploads/2024/12/14141440/11_narslt-1024x683.jpg',
      preco: '50,00',
    ),
    Atividade(
      categoria: 'Artes',
      titulo: 'Curso de Ballet Clássico',
      professor: 'Maria Luiza',
      dataHora: '15/08/2025 | 16:00',
      local: 'Ubajara',
      imagemUrl:
          'https://offloadmedia.feverup.com/secretmedianetwork.com/wp-content/uploads/2024/12/14141440/11_narslt-1024x683.jpg',
      preco: '50,00',
    ),
    Atividade(
      categoria: 'Cultura',
      titulo: 'Curso de Ballet Clássico',
      professor: 'Maria Luiza',
      dataHora: '15/08/2025 | 16:00',
      local: 'Ubajara',
      imagemUrl:
          'https://offloadmedia.feverup.com/secretmedianetwork.com/wp-content/uploads/2024/12/14141440/11_narslt-1024x683.jpg',
      preco: '50,00',
    ),
  ];

  late Map<String, List<Atividade>> categorias;

  late final HomeViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    _listarCategorias();
    _init();
  }

  void _listarCategorias() {
    categorias = {};
    for (var atividades in atividade) {
      categorias.putIfAbsent(atividades.categoria, () => []).add(atividades);
    }
  }

  Future<void> _init() async {
    final result = await viewModel.init();
    switch (result) {
      case Ok():
        break;
      case Error():
        if (mounted) {
          showErrorMessage(context, result.errorMessage);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: 'Atividades',
        hideBack: true,
        showSearch: true,
      ),
      drawer: CustomDrawer(
        name: viewModel.name,
        photo: viewModel.photo,
        type: viewModel.type,
      ),

      body: ListView(
        padding: const EdgeInsets.all(22),
        children: categorias.entries.map((entry) {
          final atividadesDaCategoria = entry.value;
          final atividadesVisiveis = atividadesDaCategoria.take(5).toList();
          final temMaisDeCinco = atividadesDaCategoria.length > 5;

          return ExpansionTile(
            iconColor: Color(0xFF9A31C9),
            collapsedIconColor: Color(0xFF9A31C9),
            initiallyExpanded: true,
            title: Text(
              entry.key,
              style: const TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            children: [
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: atividadesVisiveis.map((atividade) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 365,
                        child: CustomCards(atividade: atividade),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (temMaisDeCinco)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      print("Ver mais de ${entry.key}");
                    },
                    child: const Text(
                      'Ver mais',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9A31C9),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24), // Espaço entre categorias
            ],
          );
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/activityFormDetails');
        },
        backgroundColor: Color(0xFF9A31C9),
        child: const Icon(Icons.add),
      ),
    );
  }
}
