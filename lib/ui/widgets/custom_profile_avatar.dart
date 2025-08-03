import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibie/utils/show_image_options.dart';

class CustomProfileAvatar extends StatelessWidget {
  final String photo;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onDelete;
  final double size;
  final double svgSize;

  const CustomProfileAvatar({
    super.key,
    required this.photo,
    required this.onCamera,
    required this.onGallery,
    required this.onDelete,
    this.size = 300,
    this.svgSize = 230,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: CircleAvatar(
              radius: size / 2,
              backgroundColor: Colors.white,
              backgroundImage: photo.isEmpty
                  ? null
                  : photo.startsWith('http')
                  ? NetworkImage(photo)
                  : FileImage(File(photo)) as ImageProvider,
              child: photo.isEmpty
                  ? Transform.translate(
                      offset: Offset(0, size * 0.11),
                      child: SvgPicture.asset(
                        'assets/perfil.svg',
                        fit: BoxFit.cover,
                        width: svgSize,
                        height: svgSize,
                      ),
                    )
                  : null,
            ),
          ),
          Positioned(
            right: 7,
            child: GestureDetector(
              onTap: () {
                showImageOptions(
                  context: context,
                  onCamera: () {
                    onCamera();
                  },
                  onGallery: () {
                    onGallery();
                  },
                  onDelete: () {
                    onDelete();
                  },
                );
              },
              child: Container(
                width: size * 0.23,
                height: size * 0.23,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF71A151),
                ),
                padding: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(6.5),
                  child: SvgPicture.asset(
                    'assets/camera_icon.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
