import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/models/activity.dart';

class CustomInstructorSummaryCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback onCardTap;

  const CustomInstructorSummaryCard({
    super.key,
    required this.activity,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (activity.status.toLowerCase()) {
      case 'active':
        statusColor = Colors.green;
        break;
      case 'completed':
        statusColor = Colors.grey;
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
          padding: const EdgeInsets.all(8.0),
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
                        right: BorderSide(width: 2, color: Color(0xFF9A31C9)),
                        bottom: BorderSide(width: 2, color: Color(0xFF9A31C9)),
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
                          child: SvgPicture.asset(
                            'assets/placeholder.svg',
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
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
                            Text(
                              () {
                                final totalVacancies = activity.vacancies.isEmpty
                                    ? 0
                                    : int.tryParse(activity.vacancies) ?? 0;
                                final remaining = activity.remainingVacancies.isEmpty
                                    ? 0
                                    : int.tryParse(activity.remainingVacancies) ?? 0;
                                final enrolled = totalVacancies - remaining;
                                return '$enrolled inscritos';
                              }(),
                              style: const TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 13,
                                color: Color(0xFF71A151),
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: -5,
                          right: 2,
                          child: Text(
                            activity.status.toLowerCase() == 'completed'
                            ? 'CONCLUÍDA'
                            : activity.status.toLowerCase() == 'active'
                            ? 'ATIVA'
                            : activity.status.toUpperCase(),
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