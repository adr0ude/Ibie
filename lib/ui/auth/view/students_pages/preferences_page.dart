import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/login_prompt.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/models/activity_category.dart';

import 'package:ibie/ui/auth/viewModel/register_student_viewmodel.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key, required this.viewModel});

  final RegisterStudentViewmodel viewModel;

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  late final RegisterStudentViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(
        title: 'Cadastro de Conta',
        showSkip: true,
        onSkip: () async {
          final result = await viewModel.signUpEmail();
          switch (result) {
            case Ok():
              Navigator.pushReplacementNamed(context, '/successStudent');
            case Error():
              showErrorMessage(context, result.errorMessage);
          }
        },
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Adicione suas preferências:',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 30),
            GridView.count(
              shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: NeverScrollableScrollPhysics(),
                children: defaultCategories.asMap().entries.map((entry) {
                  final index = entry.key;
                  final categoria = entry.value;
                  final bool cores = true;
                  final bool ativa = viewModel.selectedCategories.contains(categoria.name);
                  final Color cor = cores ? (index == 0 || index == 3 || index == 4 ? Color(0xFF9A31C9) : Color(0xFF71A151)) : Color(0xFFC3E29E);
                  final Color corContainer = ativa ? Color(0xFFC3E29E) : Color(0xFFFFFFFF);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        viewModel.changeList(categoria.name);
                      });
                    },
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
                            child: SvgPicture.asset(
                              categoria.icon,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            categoria.name.toUpperCase(),
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

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomWhiteButton(
                  label: 'Cancelar', 
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  }, 
                  size: Size(175,40)
                ),
                CustomPurpleButton(
                  label: 'Registrar', 
                  onPressed: () async {
                    final result = await viewModel.signUpEmail();
                    switch (result) {
                      case Ok():
                        Navigator.pushReplacementNamed(context, '/successStudent');
                      case Error():
                        showErrorMessage(context, result.errorMessage);
                    }
                  }, 
                  size: Size(175, 40)
                ),
              ],
            ),

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

              SizedBox(height: 18),
              LoginPrompt(),

              SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}