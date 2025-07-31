// lib/ui/activity_manager/widgets/gerenciar_atividade_card.dart

import 'package:flutter/material.dart';
import 'package:ibie/models/atividades_cards.dart';

class GerenciarAtividadeCard extends StatelessWidget {
  final Atividade atividade;
  final VoidCallback? onCardTap;
  final String cardStatusText; // <--- GARANTA QUE ESTA LINHA ESTÁ AQUI

  const GerenciarAtividadeCard({
    super.key,
    required this.atividade,
    this.onCardTap,
    required this.cardStatusText, // <--- E ESTA LINHA AQUI NO CONSTRUTOR
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (cardStatusText) {
      // Usa cardStatusText para definir a cor
      case 'ATIVA':
        statusColor = Colors.green;
        break;
      case 'CONCLUÍDA':
        statusColor = Colors.purple;
        break;
      case 'DESATIVADO':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFFF3CEED), width: 4),
        ),
        child: SizedBox(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  atividade.imagemUrl,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 120,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            atividade.titulo,
                            style: const TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            atividade.professor,
                            style: TextStyle(
                              fontSize: 16,
                              color: atividade.professor.contains('Prof.')
                                  ? const Color(0xFF9A31C9)
                                  : const Color(0xFF71A151),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Text(
                          cardStatusText, // <--- AGORA USA cardStatusText AQUI
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
