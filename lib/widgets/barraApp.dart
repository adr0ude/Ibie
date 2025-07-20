import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final VoidCallback? onSkip;
  final bool showSkip;
  final bool showSearch;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onSearch,
    this.onSkip,
    this.showSkip = false,
    this.showSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      actions: [
        if(showSkip == true)
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
        if(showSearch == true)
        IconButton(icon: const Icon(Icons.search, color: Colors.black),
        onPressed: onSearch,)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}