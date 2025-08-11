import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/widgets/feedback_box.dart';
import 'package:ibie/ui/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/utils/big_decoration_form.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class CompletedSubscriptionColumn extends StatefulWidget {
  final ActivityDetailsViewmodel viewModel;

  const CompletedSubscriptionColumn({super.key, required this.viewModel});

  @override
  State<CompletedSubscriptionColumn> createState() => _CompletedSubscriptionColumnState();
}

class _CompletedSubscriptionColumnState extends State<CompletedSubscriptionColumn> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return Column(
      children: [
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
          const SizedBox(height: 20),
        ],
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Feedback:",
            style: TextStyle(
              color: Colors.purple,
              fontFamily: 'Comfortaa',
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            width: 380,
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: 120,
                    child: TextFormField(
                      onChanged: (value) => viewModel.comment = value,
                      maxLines: 3,
                      minLines: 3,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: bigDecorationForm(
                        "Avalie o curso por meio de um comentário...",
                        size: const Size(380, 120),
                        fontSize: 16,
                      ),
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black.withAlpha(178),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escreva um comentário!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  right: 10,
                  child: GestureDetector(
                    onTap: !viewModel.isLoading
                      ? () async {
                        showPopUp(
                          context: context,
                          title: 'Enviar comentário',
                          text: 'Você confirma o envio do comentário na atividade ${viewModel.title}?',
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final sendResult = await viewModel.sendFeedback();
                              switch (sendResult) {
                                case Ok():
                                  showOkMessage(context, 'Comentário enviado');
                                  if (mounted) {
                                    Navigator.pushReplacementNamed(context, '/home');
                                  }
                                case Error():
                                  showErrorMessage(context, sendResult.errorMessage);
                              }
                            }
                          },
                        );
                      }
                      : null,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF7AA55D),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        'assets/send_icon.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}