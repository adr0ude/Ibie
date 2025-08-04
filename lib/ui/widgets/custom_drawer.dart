import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/widgets/custom_green_button.dart';
import 'package:ibie/ui/widgets/custom_profile_avatar.dart';
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
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset('assets/slice_perfil.svg', fit: BoxFit.contain),
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
                  child: CustomProfileAvatar(
                    photo: widget.photo,
                    onCamera: () {},
                    onGallery: () {},
                    onDelete: () {},
                    size: 200,
                    svgSize: 153,
                    showCamera: false,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
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
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            size: Size(280, 50),
          ),
          SizedBox(height: 9),
          CustomWhiteButton(
            label: 'Minhas Atividades',
            onPressed: () {
              Navigator.pushNamed(context, '/myActivities');
            },
            size: Size(280, 50),
          ),
          SizedBox(height: 350),
          CustomGreenButton(
            label: 'Sair',
            onPressed: () {
              Navigator.pushNamed(context, '/welcome');
            },
            size: Size(280, 50),
          ),
        ],
      ),
    );
  }
}
