import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/custom_drawer.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

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
    final result = await viewModel.init();
    switch (result) {
      case Ok():
        break;
      case Error():
        if(mounted) {
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
    );
  }
}