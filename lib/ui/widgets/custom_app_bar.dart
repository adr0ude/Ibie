import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final VoidCallback? onSkip;
  final bool showSkip;
  final bool hideBack;
  final bool showSearch;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onSearch,
    this.onSkip,
    this.showSkip = false,
    this.hideBack = false,
    this.showSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      elevation: 4.0,
      shadowColor: const Color.fromARGB(150, 0, 0, 0),
      leading: hideBack
    ? null
    : IconButton(
        icon: SvgPicture.asset(
          'assets/arrow_back_icon.svg',
          width: 18,
          height: 18,
        ),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      actions: [
        if (showSkip == true)
          TextButton(
            onPressed: onSkip,
            child: const Text(
              'Pular',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9A31C9),
              ),
            ),
          ),
        if (showSearch == true)
          IconButton(
            icon: SvgPicture.asset(
              'assets/search_icon.svg',
              width: 22,
              height: 22,
            ),
            onPressed: onSearch,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}