import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../routing/app_router.dart';
import 'image_preview_screen.dart';
import 'media_picker_service.dart';

class MediaViewerScreen extends StatefulWidget {
  const MediaViewerScreen({super.key});

  @override
  State<MediaViewerScreen> createState() => _MediaViewerScreenState();
}

class _MediaViewerScreenState extends State<MediaViewerScreen> {
  final _mediaPicker = MediaPickerService();
  bool _isPicking = false;

  Future<void> _pickImage({required bool useCamera}) async {
    setState(() => _isPicking = true);
    try {
      final media = useCamera
          ? await _mediaPicker.pickFromCamera()
          : await _mediaPicker.pickFromGallery();
      if (!mounted || media == null) return;
      await Navigator.pushNamed(
        context,
        AppRouter.imagePreview,
        arguments: ImagePreviewArguments.bytes(
          bytes: media.bytes,
          title: media.fileName,
        ),
      );
    } on PlatformException catch (error) {
      _showError(error.message ?? 'Could not open the image picker.');
    } on Exception catch (error) {
      _showError('Could not load the selected image: $error');
    } finally {
      if (mounted) setState(() => _isPicking = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared media')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.photo_library_outlined, size: 56),
              const SizedBox(height: 16),
              Text(
                'Choose a photo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text('Pick an image to preview it on this device.'),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _isPicking
                    ? null
                    : () => _pickImage(useCamera: false),
                icon: _isPicking
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.photo_library_outlined),
                label: const Text('Choose from gallery'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _isPicking
                    ? null
                    : () => _pickImage(useCamera: true),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Take a photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
