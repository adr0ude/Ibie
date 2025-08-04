import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/models/summary_activity.dart';

class CustomSummaryCard extends StatelessWidget {
  final SummaryActivity activity;
  final VoidCallback onCardTap;
  final VoidCallback onProfessorTap;

  const CustomSummaryCard({
    super.key,
    required this.activity,
    required this.onCardTap,
    required this.onProfessorTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (activity.status.toLowerCase()) {
      case 'ativa':
        statusColor = Colors.green;
        break;
      case 'concluída':
        statusColor = Colors.purple;
        break;
      case 'cancelada':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            right: BorderSide(color: Color(0xFFF3CEED), width: 4),
            bottom: BorderSide(color: Color(0xFFF3CEED), width: 4),
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: const Border(
                        right: BorderSide(width: 3, color: Color(0xFF9A31C9)),
                        bottom: BorderSide(width: 3, color: Color(0xFF9A31C9)),
                      ),
                    ),
                    child: Image.network(
                      activity.image,
                      width: 122,
                      height: 109,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 122,
                          height: 109,
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
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.title,
                              style: const TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/professor_icon.svg',
                                  width: 18,
                                  height: 18,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: onProfessorTap,
                                    child: Text(
                                      "Professor(a) ${activity.userName}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF000000),
                                        decoration: TextDecoration.underline,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 8,
                          child: Text(
                            activity.status.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontSize: 13,
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
      ),
    );
  }
}
