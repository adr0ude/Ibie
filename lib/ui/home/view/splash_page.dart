import 'package:flutter/material.dart';
import 'package:ibie/ui/home/view_model/splash_page_viewmodel.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    required this.viewModel,
  });

  final SplashPageViewModel viewModel;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashPageViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {

    final result = await viewModel.checkLoginStatus();

    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    switch (result) {
      case Ok():
        if (viewModel.isLoggedIn) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
        }
        break;

      case Error():
        showErrorMessage(context, result.errorMessage);
        Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFF9A31C9)),
      ),
    );
  }
}