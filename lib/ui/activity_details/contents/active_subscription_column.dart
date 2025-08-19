import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/widgets/buttons/custom_favorite_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/feedback_box.dart';
import 'package:ibie/ui/activity_details/activity_details_viewmodel.dart';
import 'package:ibie/utils/big_decoration_form.dart';
import 'package:ibie/utils/results.dart';
import 'package:ibie/utils/show_error_message.dart';
import 'package:ibie/utils/show_ok_message.dart';
import 'package:ibie/utils/show_pop_up.dart';

class ActiveSubscriptionColumn extends StatefulWidget {
  final ActivityDetailsViewmodel viewModel;

  const ActiveSubscriptionColumn({super.key, required this.viewModel});

  @override
  State<ActiveSubscriptionColumn> createState() =>
      _ActiveSubscriptionColumnState();
}

class _ActiveSubscriptionColumnState extends State<ActiveSubscriptionColumn> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final scaffoldContext = context;
    final viewModel = widget.viewModel;
    return Column(
      children: [
        if (widget.viewModel.comments.isNotEmpty) ...[
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
            children: widget.viewModel.comments.map((comment) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: FeedbackBox(text: comment),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
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
                      maxLines: 4,
                      minLines: 4,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: bigDecorationForm(
                        "Escreva um comentário...",
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
                          return 'Escreva um comentário antes de enviar';
                        } else if (value.length > 300) {
                          return 'Número máximo de caracteres atingido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ListenableBuilder(
                    listenable: viewModel,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: !viewModel.isLoading
                            ? () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  showPopUp(
                                    context: scaffoldContext,
                                    title: 'Enviar comentário',
                                    text:
                                        'Você confirma o envio do comentário na atividade ${viewModel.title}?',
                                    onPressed: () async {
                                      final sendResult = await viewModel
                                          .sendFeedback();
                                      switch (sendResult) {
                                        case Ok():
                                          showOkMessage(
                                            scaffoldContext,
                                            'Comentário enviado',
                                          );
                                          if (mounted) {
                                            Navigator.pushNamedAndRemoveUntil(
                                              scaffoldContext,
                                              '/home',
                                              (route) => false,
                                            );
                                          }
                                        case Error():
                                          showErrorMessage(
                                            scaffoldContext,
                                            sendResult.errorMessage,
                                          );
                                      }
                                    },
                                  );
                                }
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, child) {
                  return CustomPurpleButton(
                    label: 'Cancelar inscrição',
                    onPressed: !widget.viewModel.isLoading
                        ? () {
                            showPopUp(
                              context: scaffoldContext,
                              title: 'Cancelar Inscrição',
                              text:
                                  'Você confirma o cancelamento da sua inscrição na atividade ${widget.viewModel.title}?',
                              onPressed: () async {
                                final unsubscribeResult = await widget.viewModel.unsubscribe();
                                Navigator.pop(scaffoldContext);
                                switch (unsubscribeResult) {
                                  case Ok():
                                    showOkMessage(scaffoldContext, 'Cancelamento bem-sucedido');
                                    Navigator.pushNamedAndRemoveUntil(scaffoldContext, '/home', (route) => false);
                                  case Error():
                                    showErrorMessage(scaffoldContext, unsubscribeResult.errorMessage);
                                }
                              },
                            );
                          }
                        : null,
                    size: const Size(285, 40),
                  );
                },
              ),
              const SizedBox(width: 5),
              ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return CustomFavoriteButton(
                    onPressed: !widget.viewModel.isLoading
                        ? () async {
                            if (widget.viewModel.isFavorite) {
                              final unfavoriteResult = await widget.viewModel
                                  .unfavorite();
                              switch (unfavoriteResult) {
                                case Ok():
                                  break;
                                case Error():
                                  showErrorMessage(
                                    scaffoldContext,
                                    unfavoriteResult.errorMessage,
                                  );
                              }
                            } else {
                              final favoriteResult = await widget.viewModel
                                  .favorite();
                              switch (favoriteResult) {
                                case Ok():
                                  break;
                                case Error():
                                  showErrorMessage(
                                    context,
                                    favoriteResult.errorMessage,
                                  );
                              }
                            }
                            final listResult = await widget.viewModel
                                .listFavorites();
                            switch (listResult) {
                              case Ok():
                                break;
                              case Error():
                                showErrorMessage(
                                  context,
                                  listResult.errorMessage,
                                );
                            }
                            setState(() {});
                          }
                        : null,
                    icon: widget.viewModel.isFavorite
                        ? "assets/favorite-star-icon.svg"
                        : "assets/unfavorite-star-icon.svg",
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
