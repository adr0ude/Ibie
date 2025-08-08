import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/activities/my_activities/my_activities_viewmodel.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/custom_summary_card.dart';

import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({super.key, required this.viewModel});

  final MyActivitiesViewmodel viewModel;

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
  late final MyActivitiesViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    _init();
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
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFFF4F5F9),
          appBar: CustomAppBar(
            title: 'Minhas Atividades',
            onBack: () => Navigator.pushReplacementNamed(context, '/home'),
          ),

          body: viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF9A31C9)),
                )
              : viewModel.activities.isEmpty
              ? Center(
                child: Column(
                    children: [
                      SizedBox(height: 70),
                      Text(
                        'Não há atividades',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF000000),
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'inscritas para mostrar!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF000000),
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 130),
                      SvgPicture.asset(
                        'assets/empty_icon.svg',
                        width: 285,
                        height: 210.9,
                      ),
                      SizedBox(height: 130),
                      Text(
                        'Clique no botão abaixo para\n descobrir novas atividades.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF000000),
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      SizedBox(height: 70),
                      CustomPurpleButton(
                        label: 'Explorar novas atividades', 
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        size: Size(354, 52),
                      ),
                    ],
                  ),
              )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: viewModel.activities.map((a) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CustomSummaryCard(
                          activity: a,
                          onCardTap: () {
                            Navigator.pushNamed(context, '/activity', arguments: a.activity.id);
                          },
                          onProfessorTap: () {
                            print('professor clicado');
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
        );
      },
    );
  }
}
