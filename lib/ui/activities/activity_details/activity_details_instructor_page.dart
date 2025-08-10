import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/activities/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/ui/activities/activity_details/contents/details_instructor_column.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

class ActivityDetailsInstructorPage extends StatefulWidget {
  const ActivityDetailsInstructorPage({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  final ActivityDetailsViewmodel viewModel;
  final String activityId;

  @override
  State<ActivityDetailsInstructorPage> createState() => _ActivityDetailsInstructorPageState();
}

class _ActivityDetailsInstructorPageState extends State<ActivityDetailsInstructorPage> {
  late final ActivityDetailsViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    _getNames();
  }

  Future<void> _getNames() async {
    final result = await viewModel.getStudentsNames(widget.activityId);
    switch (result) {
      case Ok():
        setState(() {});
      case Error():
        if (mounted) {
          showErrorMessage(context, result.errorMessage);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(title: 'Detalhes da atividade', onBack: () => Navigator.pushReplacementNamed(context, '/home')),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF9A31C9)),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 170,
                    child: Image.network(
                      viewModel.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          'assets/placeholder.svg',
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF9A31C9),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            viewModel.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/instructor', arguments: viewModel.instructorId);
                          },
                          child: Text(
                            "Professor(a) ${viewModel.userName}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Comfortaa',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 400,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              right: BorderSide(color: Color(0xFFF3CEED), width: 2),
                              bottom: BorderSide(
                                color: Color(0xFFF3CEED),
                                width: 2,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sobre a atividade',
                                style: TextStyle(
                                  color: const Color(0xFF9A31C9),
                                  fontFamily: 'Comfortaa',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                viewModel.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  wordSpacing: -0.5,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            infoTag(Icons.person, "13 alunos inscritos"),
                          ],
                        ),
                        SizedBox(height: 20),
                        DetailsInstructorColumn(viewModel: viewModel),                 
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget infoTag(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 18, color: const Color(0xFF9A31C9)),
      label: Text(text),
      backgroundColor: Colors.grey[200],
    );
  }
}
