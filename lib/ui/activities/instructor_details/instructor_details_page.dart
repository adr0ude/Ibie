import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/activities/instructor_details/instructor_details_view_model.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/ui/widgets/cards/custom_instructor_course_card.dart';
import 'package:ibie/ui/widgets/custom_profile_avatar.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

class InstructorDetailsPage extends StatefulWidget {
  const InstructorDetailsPage({
    super.key,
    required this.viewModel,
    required this.instructorId,
  });

  final InstructorDetailsViewModel viewModel;
  final String instructorId;

  @override
  State<InstructorDetailsPage> createState() => _InstructorDetailsPageState();
}

class _InstructorDetailsPageState extends State<InstructorDetailsPage> {
  late final InstructorDetailsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    _init();
  }

  Future<void> _init() async {
    final result = await viewModel.init(widget.instructorId);
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
      appBar: CustomAppBar(title: 'Detalhes do Instrutor'),
      backgroundColor: Color(0xFFF4F5F9),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF9A31C9)),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    CustomProfileAvatar(
                      photo: viewModel.photo,
                      onCamera: () {},
                      onGallery: () {},
                      onDelete: () {},
                      size: 250,
                      svgSize: 153,
                      showCamera: false,
                      color: const Color(0xFF9A31C9),
                    ),

                    SizedBox(height: 21),
                    Text(
                      viewModel.name,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: 400,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                          right: BorderSide(color: Color(0xFF71A151), width: 2),
                          bottom: BorderSide(
                            color: Color(0xFF71A151),
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
                            'Sobre',
                            style: TextStyle(
                              color: Color(0xFF71A151),
                              fontFamily: 'Comfortaa',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            viewModel.biography,
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
                    SizedBox(height: 20),
                    Container(
                      width: 375,
                      height: 95,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                          right: BorderSide(color: Color(0xFF71A151), width: 2),
                          bottom: BorderSide(
                            color: Color(0xFF71A151),
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
                            'Contato',
                            style: TextStyle(
                              color: Color(0xFF71A151),
                              fontFamily: 'Comfortaa',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/phone_icon.svg',
                                width: 23.56,
                                height: 26.92,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset(
                                'assets/whatsapp_icon.svg',
                                width: 23.56,
                                height: 26.92,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 11),
                              Text(
                                viewModel.phone,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Cursos ativos:',
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        children: viewModel.activities.map((a) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomInstructorCourseCard(
                              activity: a,
                              onCardTap: () {
                                Navigator.pushNamed(context, '/activity', arguments: a.id);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
