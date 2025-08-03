import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibie/ui/widgets/custom_green_button.dart';
import 'package:ibie/ui/widgets/custom_white_button.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.name,
    required this.photo,
    required this.type,
  });

  final String name;
  final String photo;
  final String type;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFFFFFFF),
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/slice_perfil.svg',
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF71A151),
                        width: 1,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xFFFFFFFF),
                      backgroundImage:
                          widget.photo != null && widget.photo.isNotEmpty
                          ? NetworkImage(widget.photo)
                          : null,
                      child: widget.photo.isEmpty
                          ? ClipOval(
                              child: SvgPicture.asset(
                                'assets/perfil.svg',
                                fit: BoxFit.cover,
                                width: 150,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 120),
            Text(
              widget.name,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Text(
              widget.type.toLowerCase() == 'student'
                  ? 'ALUNO'
                  : widget.type.toLowerCase() == 'instructor'
                  ? 'INSTRUTOR'
                  : widget.type.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFF71A151),
              ),
            ),
            SizedBox(height: 18),
            CustomWhiteButton(
              label: 'Perfil',
              onPressed: () {},
              size: Size(280, 50),
            ),
            SizedBox(height: 9),
            CustomWhiteButton(
              label: 'Minhas Atividades',
              onPressed: () {},
              size: Size(280, 50),
            ),
            SizedBox(height: 280),
            CustomGreenButton(
              label: 'Sair',
              onPressed: () {},
              size: Size(280, 50),
            ),
          ],
        ),
      ),
      //child: Center(child: Text(widget.name)),
    );
  }
}
