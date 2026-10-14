import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class PickedMedia {
  const PickedMedia({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });

  final Uint8List bytes;
  final String fileName;
  final String mimeType;
}

class MediaPickerService {
  MediaPickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<PickedMedia?> pickFromGallery() {
    return pickImage(source: ImageSource.gallery);
  }

  Future<PickedMedia?> pickFromCamera() {
    return pickImage(source: ImageSource.camera);
  }

  Future<PickedMedia?> pickImage({ImageSource source = ImageSource.gallery}) {
    return _pickImage(source);
  }

  Future<PickedMedia?> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(
      source: source,
      requestFullMetadata: false,
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    final extension = file.name.split('.').last.toLowerCase();
    final mimeType = switch (extension) {
      'png' => 'image/png',
      'webp' => 'image/webp',
      'gif' => 'image/gif',
      'heic' || 'heif' => 'image/heic',
      _ => 'image/jpeg',
    };
    return PickedMedia(
      bytes: bytes,
      fileName: file.name,
      mimeType: mimeType,
    );
  }
}
