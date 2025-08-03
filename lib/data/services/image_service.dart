import 'package:image_picker/image_picker.dart';

import 'package:ibie/utils/results.dart';

class ImageService {
  final ImagePicker _picker;

  ImageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  Future<Result<String?>> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return Result.ok(image?.path);
  }

  Future<Result<String?>> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return Result.ok(image?.path);
  }
}