import 'package:flutter/material.dart';
import 'package:ibie/config/routes.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';

import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/cards/custom_student_summary_card.dart';
import 'package:ibie/ui/widgets/cards/custom_instructor_summary_card.dart';
import 'package:ibie/ui/my_activities/contents/empty_screen_instructor.dart';
import 'package:ibie/ui/my_activities/contents/empty_screen_student.dart';
import 'package:ibie/ui/my_activities/my_activities_viewmodel.dart';

import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

import 'package:ibie/models/activity.dart';
import 'package:ibie/models/enrolled_activity.dart';

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

  Widget _buildEnrolledActivityCards(
    List<EnrolledActivity> enrolledActivities,
  ) {
    return Column(
      children: enrolledActivities.map((a) {
        return CustomStudentSummaryCard(
          activity: a,
          onCardTap: () {
            Navigator.pushNamed(context, '/activity', arguments: a.activity.id);
          },
          onInstructorTap: () {
            Navigator.pushNamed(
              context,
              '/instructor',
              arguments: a.activity.userId,
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildMyActivityCards(List<Activity> myActivities) {
    return Column(
      children: myActivities.map((a) {
        return CustomInstructorSummaryCard(
          activity: a,
          onCardTap: () {
            Navigator.pushNamed(context, '/activity', arguments: a.id);
          },
        );
      }).toList(),
    );
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
              : viewModel.enrolledActivities.isEmpty &&
                    viewModel.myActivities.isEmpty
              ? viewModel.type == 'student'
                    ? EmptyScreenStudent()
                    : EmptyScreenInstructor()
              : Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (viewModel.type.isNotEmpty &&
                                  viewModel.type == 'student')
                                _buildEnrolledActivityCards(
                                  viewModel.enrolledActivities,
                                ),
                              if (viewModel.type.isNotEmpty &&
                                  viewModel.type == 'instructor') ...[
                                if (viewModel.enrolledActivities.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Atividades Inscritas",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF9A31C9),
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                _buildEnrolledActivityCards(
                                  viewModel.enrolledActivities,
                                ),
                                SizedBox(height: 10),
                                if (viewModel.myActivities.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Gerenciar Atividades",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF9A31C9),
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                _buildMyActivityCards(viewModel.myActivities),
                              ],
                            ],
                          ),
                        ),
                      ),
                      if (viewModel.type == 'instructor')
                        CustomWhiteButton(
                          label: 'Adicionar atividade',
                          isGreen: true,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/activityFormDetails',
                              arguments: ActivityFormDetailsArgs(),
                            );
                          },
                          size: Size(354, 52),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
