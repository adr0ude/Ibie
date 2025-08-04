import 'package:flutter/material.dart';
import 'package:ibie/ui/profile/profile_viewmodel.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class PassPrompt extends StatelessWidget {
  const PassPrompt({super.key, required this.viewModel});

  final ProfileViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Expanded(child: Divider(color: Color(0xFF767474), thickness: 1)),
          SizedBox(width: 5),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showPopUp(
                  context: context,
                  title: 'Redefinir senha', 
                  text: 'Deseja receber um email para redefinição de senha?', 
                  onPressed: () async {
                    final result = await viewModel.sendEmail();
                      switch (result) {
                        case Ok():
                          Navigator.pushReplacementNamed(context, '/login');
                          showOkMessage(context, 'E-mail enviado');
                        case Error():
                          showErrorMessage(context, result.errorMessage);
                      }
                  }
                );
              },
              child: Padding(
                padding: EdgeInsetsGeometry.all(4),
                child: Text(
                  'Redefinir senha?',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF9A31C9),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF9A31C9),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(child: Divider(color: Color(0xFF767474), thickness: 1)),
        ],
      ),
    );
  }
}