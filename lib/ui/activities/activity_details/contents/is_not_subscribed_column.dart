import 'package:flutter/material.dart';
import 'package:ibie/ui/widgets/buttons/custom_favorite_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/feedback_box.dart';
import 'package:ibie/ui/activities/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class IsNotSubscribedColumn extends StatelessWidget {
  final ActivityDetailsViewmodel viewModel;

  const IsNotSubscribedColumn({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 249,
          height: 77,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF71A151),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                viewModel.remainingVacancies,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                ),
              ),
              const Text(
                "vagas disponíveis!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (viewModel.comments.isNotEmpty) ...[
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
          const SizedBox(height: 15),
        ],
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPurpleButton(
                label: 'Inscrever-se',
                onPressed: () {
                  showPopUp(
                    context: context,
                    title: 'Realizar Inscrição',
                    text:'Você confirma a sua inscrição na atividade ${viewModel.title}?',
                    onPressed: () async {
                      final subscribeResult = await viewModel.subscribe();
                      Navigator.pop(context);
                      switch (subscribeResult) {
                        case Ok():
                          showOkMessage(context, 'Inscrição bem-sucedida');
                          Navigator.pushReplacementNamed(context, '/home');
                        case Error():
                          showErrorMessage(context, subscribeResult.errorMessage);
                      }
                    },
                  );
                },
                size: const Size(285, 40),
              ),
              const SizedBox(width: 5),
              CustomFavoriteButton(onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}