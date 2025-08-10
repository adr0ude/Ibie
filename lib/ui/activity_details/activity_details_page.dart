import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/ui/activity_details/contents/active_subscription_column.dart';
import 'package:ibie/ui/activity_details/contents/completed_subscription_column.dart';
import 'package:ibie/ui/activity_details/contents/is_not_subscribed_column.dart';
import 'package:ibie/ui/widgets/buttons/custom_green_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/config/routes.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  final ActivityDetailsViewmodel viewModel;
  final String activityId;

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  late final ActivityDetailsViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;

    _init();
  }

  Future<void> _init() async {
    final initResult = await viewModel.init(widget.activityId);
    switch (initResult) {
      case Ok():
        setState(() {});
      case Error():
        if (mounted) {
          showErrorMessage(context, initResult.errorMessage);
        }
    }

    final favoritesResult = await viewModel.listFavorites();
    switch (favoritesResult) {
      case Ok():
        setState(() {});
      case Error():
        if (mounted) {
          showErrorMessage(context, favoritesResult.errorMessage);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: CustomAppBar(title: 'Detalhes da atividade'),
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
                            infoTag(Icons.calendar_today, "Sexta-feira"),
                            infoTag(Icons.location_on, "Escola Azul"),
                            infoTag(Icons.child_care, "6 a 12 anos"),
                            infoTag(Icons.palette, "Artístico"),
                            infoTag(Icons.attach_money, "R\$50,00"),
                          ],
                        ),
                        SizedBox(height: 24),
                        if(viewModel.instructorId == viewModel.userId) ... [
                          SizedBox(height: 10),
                          CustomPurpleButton(
                            label: 'Ver mais detalhes',
                            onPressed: !viewModel.isLoading
                              ? () {
                                Navigator.pushNamed(context, '/activityDetailsInstructor', arguments: ActivityDetailsArgs(widget.viewModel, widget.activityId));
                              }
                              : null,
                            size: Size(354, 52),
                          ),
                          SizedBox(height: 15),
                          CustomGreenButton(
                            label: 'Editar atividade',
                            onPressed: !viewModel.isLoading
                              ? () {
                                Navigator.pushNamed(
                                  context,
                                  '/activityFormDetails',
                                  arguments: ActivityFormDetailsArgs(
                                    isEditing: true,
                                    activityId: widget.activityId,
                                  ),
                                );
                              }
                              : null,
                            size: Size(354, 52),
                          ),
                          SizedBox(height: 15),
                          CustomWhiteButton(
                            label: 'Remover atividade',
                            onPressed: !viewModel.isLoading
                              ? () {
                                showPopUp(
                                  context: context, 
                                  title: 'Remover Atividade', 
                                  text: 'Você confirma a remoção da atividade Curso ${viewModel.title}?', 
                                  onPressed: () async {
                                    final deleteResult = await viewModel.deleteActivity(widget.activityId);
                                    switch (deleteResult) {
                                      case Ok():
                                        showOkMessage(context, 'Exclusão bem-sucedida');
                                        if (mounted) {
                                          Navigator.pushReplacementNamed(context, '/home');
                                        }
                                      case Error():
                                        showErrorMessage(context, deleteResult.errorMessage);
                                    }
                                  }
                                );
                              }
                              : null,
                            size: Size(354, 52),
                          ),
                          SizedBox(height: 15),
                          CustomWhiteButton(
                            label: 'Marcar como concluída',
                            isGreen: true,
                            onPressed: !viewModel.isLoading
                              ? () {
                                showPopUp(
                                  context: context, 
                                  title: 'Marcar como Concluída', 
                                  text: 'Realmente deseja marcar a atividade ${viewModel.title} como concluída? Após essa ação, ela não receberá novas inscrições e deixará de aparecer na página inicial de cursos.', 
                                  onPressed: () async {
                                    final markResult = await viewModel.markAsCompleted(widget.activityId);
                                    switch (markResult) {
                                      case Ok():
                                        showOkMessage(context, 'Marcação bem-sucedida');
                                        if (mounted) {
                                          Navigator.pushReplacementNamed(context, '/home');
                                        }
                                      case Error():
                                        showErrorMessage(context, markResult.errorMessage);
                                    }
                                  }
                                );
                              }
                              : null,
                            size: Size(354, 52),
                          ),  
                        ],
                          
                        if (viewModel.instructorId != viewModel.userId) ...[
                          if (!viewModel.isSubscribed)
                            IsNotSubscribedColumn(viewModel: viewModel),
  
                          if (viewModel.isSubscribed)
                            Builder(
                              builder: (_) {
                                final summary = viewModel.activities.firstWhere(
                                  (a) => a.activity.id == widget.activityId,
                                );

                                switch (summary.status.toLowerCase()) {
                                  case 'active':
                                    return ActiveSubscriptionColumn(viewModel: viewModel);
                                  case 'completed':
                                    return CompletedSubscriptionColumn(viewModel: viewModel);
                                  case 'canceled':
                                    return IsNotSubscribedColumn(viewModel: viewModel);
                                  default:
                                    return const Text('Status desconhecido');
                                }
                              },
                            ),
                        ],
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