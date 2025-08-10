import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibie/utils/show_image_options.dart';

class CustomActivityImage extends StatelessWidget {
  final String image;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onDelete;

  const CustomActivityImage({
    super.key,
    required this.image,
    required this.onCamera,
    required this.onGallery,
    required this.onDelete,
  });

  String getFileName(String path) {
    final uri = Uri.parse(path);

    if (path.startsWith('http')) {
      final decoded = Uri.decodeFull(uri.pathSegments.last);
      final name = decoded.split('?').first;
      return name.contains('/') ? name.split('/').last : name;
    } else {
      return File(path).uri.pathSegments.last;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = image.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF9A31C9), width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!hasImage) ...[
            SvgPicture.asset('assets/upload.svg', width: 60, height: 60),
            const SizedBox(height: 12),
            const Text(
              'Envie imagens de divulgação\nda atividade.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            const Text(
              'Selecione arquivos .png ou .jpg',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showImageOptions(
                  context: context,
                  onCamera: onCamera,
                  onGallery: onGallery,
                  onDelete: onDelete,
                  showTitle: false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF71A151),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Selecionar arquivo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ] else ...[
            image.startsWith('http')
                ? Image.network(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(image),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 12),
            Text(
              getFileName(image), // ✅ Aqui a correção
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showImageOptions(
                  context: context,
                  onCamera: onCamera,
                  onGallery: onGallery,
                  onDelete: onDelete,
                  showTitle: false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0E0E0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Alterar arquivo',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
