import 'package:flutter/material.dart';

import 'package:ibie/ui/widgets/feedback_box.dart';
import 'package:ibie/ui/activities/activity_details/activity_details_viewmodel.dart';

class DetailsInstructorColumn extends StatelessWidget {
  final ActivityDetailsViewmodel viewModel;

  const DetailsInstructorColumn({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Lista de Inscritos:",
            style: TextStyle(
              color: Colors.purple,
              fontFamily: 'Comfortaa',
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF9A31C9), width: 1),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            itemCount: viewModel.studentsList.length,
            itemBuilder: (context, index) {
              final aluno = viewModel.studentsList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9A31C9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      aluno, 
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
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
        if (viewModel.comments.isNotEmpty) ...[
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
        ],
      ],
    );
  }
}
