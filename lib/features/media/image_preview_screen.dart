import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePreviewArguments {
  const ImagePreviewArguments.bytes({
    required this.bytes,
    this.title = 'Image preview',
  }) : imageUrl = null;

  const ImagePreviewArguments.url({
    required this.imageUrl,
    this.title = 'Image preview',
  }) : bytes = null;

  final Uint8List? bytes;
  final String? imageUrl;
  final String title;
}

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({required this.arguments, super.key});

  final ImagePreviewArguments arguments;

  @override
  Widget build(BuildContext context) {
    final bytes = arguments.bytes;
    final url = arguments.imageUrl;
    final Widget image = bytes != null
        ? Image.memory(bytes, fit: BoxFit.contain)
        : url != null && url.isNotEmpty
        ? Image.network(
            url,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) =>
                const Center(child: Text('Could not load this image.')),
          )
        : const Center(child: Text('No image was provided.'));

    return Scaffold(
      appBar: AppBar(title: Text(arguments.title)),
      backgroundColor: Colors.black,
      body: Center(child: image),
    );
  }
}
