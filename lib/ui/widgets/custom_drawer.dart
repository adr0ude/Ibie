import 'package:flutter/material.dart';

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
      child: Center(child: Text(widget.name)),
    );
  }
}