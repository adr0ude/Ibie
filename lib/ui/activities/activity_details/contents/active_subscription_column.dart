import 'package:flutter/material.dart';
import 'package:ibie/ui/widgets/custom_purple_button.dart';
import 'package:ibie/ui/widgets/feedback_box.dart';
import 'package:ibie/ui/activities/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class ActiveSubscriptionColumn extends StatelessWidget {
  final ActivityDetailsViewmodel viewModel;

  const ActiveSubscriptionColumn({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Principais Feedbacks:",
            style: TextStyle(
              color: Colors.purple,
              fontFamily: 'Comfortaa',
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: viewModel.comments.map((comment) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FeedbackBox(text: comment),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(5),
              child: CustomPurpleButton(
                label: 'Cancelar inscrição',
                onPressed: () {
                  showPopUp(
                    context: context,
                    title: 'Cancelar Inscrição',
                    text:'Você confirma o cancelamento da sua inscrição na atividade ${viewModel.title}?',
                    onPressed: () async {
                      final unsubscribeResult = await viewModel.unsubscribe();
                      Navigator.pop(context);
                      switch (unsubscribeResult) {
                        case Ok():
                          showOkMessage(context, 'Cancelamento bem-sucedido');
                          Navigator.pushReplacementNamed(context, '/home');
                        case Error():
                          showErrorMessage(context, unsubscribeResult.errorMessage);
                      }
                    },
                  );
                },
                size: const Size(354, 52),
              ),
        ),
      ],
    );
  }
}