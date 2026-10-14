import 'package:flutter/material.dart';

class MediaViewerScreen extends StatelessWidget {
  const MediaViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared media')),
      body: const Center(child: Text('Shared photos and videos will appear here.')),
    );
  }
}
