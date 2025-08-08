import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ibie/utils/results.dart';

class StorageService {
  final SupabaseClient _client;

  StorageService({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  Future<Result<void>> deleteImage({required String imageUrl}) async {
    try {
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;

      if (pathSegments.length < 2) {
        return Result.error(Exception('URL inválida para exclusão da imagem'));
      }

      final fileName = pathSegments.last;

      await _client.storage.from('profile-pictures').remove([fileName]);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Erro ao deletar a imagem'));
    }
  }

  Future<Result<String>> uploadUserImage({required String imagePath}) async {
    try {
      final file = File(imagePath);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}${p.extension(file.path)}';

      await _client.storage.from('profile-pictures').upload(fileName, file);

      final publicUrl = _client.storage
          .from('profile-pictures')
          .getPublicUrl(fileName);

      return Result.ok(publicUrl);
    } catch (e) {
      return Result.error(
        Exception('Erro inesperado ao fazer upload da imagem: $e'),
      );
    }
  }
}