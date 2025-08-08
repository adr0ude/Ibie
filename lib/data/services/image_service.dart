import 'package:image_picker/image_picker.dart';

import 'package:ibie/utils/results.dart';

class ImageService {
  final ImagePicker _picker;

  ImageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  Future<Result<String?>> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return Result.ok(image?.path);
    } catch (e) {
      return Result.error(Exception('Não foi possível escolher a imagem via câmera'));
    }
  }

  Future<Result<String?>> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return Result.ok(image?.path);
    } catch (e) {
      return Result.error(Exception('Não foi possível escolher a imagem via galeria'));
    }
  }
}