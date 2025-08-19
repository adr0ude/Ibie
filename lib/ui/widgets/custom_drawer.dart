import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibie/ui/widgets/buttons/custom_green_button.dart';
import 'package:ibie/ui/widgets/custom_profile_avatar.dart';
import 'package:ibie/ui/widgets/buttons/custom_purple_button.dart';
import 'package:ibie/ui/widgets/buttons/custom_white_button.dart';
import 'package:ibie/utils/show_ask_to_login.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.name,
    required this.photo,
    required this.type,
    required this.isLoggedIn,
    required this.onLogOut,
  });

  final String name;
  final String photo;
  final String type;
  final bool isLoggedIn;
  final FutureOr<void> Function()? onLogOut;

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
            !widget.isLoggedIn
              ? 'Sem login'
            : widget.name,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12),
          Text(
            widget.type.toLowerCase() == 'student'
                ? 'ALUNO'
                : widget.type.toLowerCase() == 'instructor'
                ? 'INSTRUTOR'
                : 'VISITANTE',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF71A151),
            ),
          ),
          SizedBox(height: 18),
          if(!widget.isLoggedIn) ...[
            CustomWhiteButton(
              label: 'Perfil',
              onPressed: () {
                showAskToLogin(context: context);
              },
              size: Size(280, 50),
              isDisabled: true,
            ),
            SizedBox(height: 9),
            CustomWhiteButton(
              label: 'Minhas Atividades',
              onPressed: () {
                showAskToLogin(context: context);
              },
              size: Size(280, 50),
              isDisabled: true,
            ),
            SizedBox(height: 200),
            Center(
              child: Text(
                'Entre na sua conta ou\ncadastre-se para acessar\ntodos os recursos do Ibiê!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontFamily: 'Comfortaa',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 50),
            CustomPurpleButton(
              label: 'Fazer login',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              size: Size(280, 50),
            ),
          ],
          if(widget.isLoggedIn) ...[
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
            SizedBox(height: 330),
            CustomGreenButton(
              label: 'Sair',
              onPressed: widget.onLogOut,
              size: Size(280, 50),
            ),
          ],
        ],
      ),
    );
  }
}