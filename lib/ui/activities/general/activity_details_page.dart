import 'package:flutter/material.dart';
import 'package:ibie/ui/activities/general/activity_details_viewmodel.dart';
import 'package:ibie/ui/activities/general/contents/active_subscription_column.dart';
import 'package:ibie/ui/activities/general/contents/completed_subscription_column.dart';
import 'package:ibie/ui/activities/general/contents/is_not_subscribed_column.dart';
import 'package:ibie/ui/widgets/custom_app_bar.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';

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
    final result = await viewModel.init(widget.activityId);
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
      appBar: CustomAppBar(title: 'Detalhes da atividade', hideBack: true),
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
                        return const Icon(Icons.broken_image);
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
                            print('Professor(a) ${viewModel.userName} clicado');
                          },
                          child: Text(
                            "Professor(a) ${viewModel.userName}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 127, 124, 127),
                              fontFamily: 'Comfortaa',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              right: BorderSide(
                                width: 3,
                                color: Color(0xFFF3CEED),
                              ),
                              bottom: BorderSide(
                                width: 3,
                                color: Color(0xFFF3CEED),
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sobre a atividade",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: const Color(0xFF913AC1),
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                viewModel.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Comfortaa',
                                ),
                                textAlign: TextAlign.justify,
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
                        if (!viewModel.isSubscribed) ...[
                          IsNotSubscribedColumn(viewModel: viewModel),
                        ],

                        if (viewModel.isSubscribed) ...[
                          Builder(
                            builder: (_) {
                              final summary = viewModel.activities.firstWhere(
                                (a) => a.id == widget.activityId,
                              );

                              switch (summary.status.toLowerCase()) {
                                case 'ativa':
                                  return ActiveSubscriptionColumn(
                                    viewModel: viewModel,
                                  );
                                case 'concluída':
                                  return CompletedSubscriptionColumn(
                                    viewModel: viewModel,
                                  );
                                case 'cancelada':
                                  return IsNotSubscribedColumn(
                                    viewModel: viewModel,
                                  );
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
