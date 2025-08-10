import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibie/models/activity.dart';
import 'package:ibie/utils/show_ask_to_login.dart';

class CustomCardHome extends StatelessWidget {
  final Activity activity;
  final VoidCallback onPressed;
  final bool isLoggedIn;

  const CustomCardHome({super.key, required this.activity, required this.onPressed, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border(
            right: BorderSide(width: 3, color: Color(0xFFF3CEED)),
            bottom: BorderSide(width: 3, color: Color(0xFFF3CEED)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              activity.image.isNotEmpty
                  ? Image.network(
                      activity.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 213,
                    )
                  : Container(
                      width: double.infinity,
                      height: 213,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/placeholder.svg',
                        width: double.infinity,
                        height: 213,
                        fit: BoxFit.fill,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/professor_icon.svg',
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            if(isLoggedIn) {
                              Navigator.pushNamed(context, '/instructor', arguments: activity.userId);
                            } else {
                              showAskToLogin(context: context);
                            }
                          },
                          child: Text(
                            "Prof. ${activity.userName}",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/calendar_icon.svg',
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 4),
                        Text(activity.date),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/location_icon.svg',
                          width: 16,
                          height: 16,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 4),
                        Text(activity.location),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        (activity.fee == '0' || activity.fee.isEmpty)
                            ? 'GRATUITO'
                            : 'R\$ ${activity.fee}',
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF71A151),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}