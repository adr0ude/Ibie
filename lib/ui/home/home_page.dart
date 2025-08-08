import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_drawer.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_complete_profile.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/ui/widgets/custom_card_home.dart';

import 'package:ibie/ui/home/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    _init();
  }

  Future<void> _init() async {
    final initResult = await viewModel.init();
    switch (initResult) {
      case Ok():
        setState(() {});
      case Error():
        if (mounted) {
          showErrorMessage(context, initResult.errorMessage);
          break;
        }
    }
    final messageResult = await viewModel.getCompleteProfileMessage();
    switch (messageResult) {
      case Ok():
        if (!viewModel.hasShowCompleteProfileMessage) {
          final setResult = await viewModel.setCompleteProfileMessage();
          switch (setResult) {
            case Ok():
              setState(() {});
            case Error():
              showErrorMessage(context, setResult.errorMessage);
          }
          if (viewModel.type == 'instructor' && viewModel.biography.isEmpty) {
            showCompleteProfile(
              context: context,
              onContinue: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/profile');
              },
            );
          }
        }
      case Error():
        if (mounted) {
          showErrorMessage(context, messageResult.errorMessage);
        }
        break;
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
        onLogOut: () async {
          final logOutResult = await viewModel.logOut();
          switch (logOutResult) {
            case Ok():
              Navigator.pushReplacementNamed(context, '/welcome');
            case Error():
              showErrorMessage(context, logOutResult.errorMessage);
          }
        },
      ),

      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF9A31C9)),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: viewModel.categories.entries.map((entry) {
                    final activitiesByCategory = entry.value;
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
                            children: activitiesByCategory.map((activity) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 365,
                                  child: CustomCardHome(
                                    activity: activity,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/activity',
                                        arguments: activity.id,
                                      );
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
      floatingActionButton: viewModel.type == 'instructor'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/activityFormDetails');
              },
              backgroundColor: const Color(0xFF9A31C9),
              child: const Icon(Icons.add, color: Colors.white,),
            )
          : null,
    );
  }
}
