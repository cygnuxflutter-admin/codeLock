import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenImageViewer extends StatelessWidget {
  final Widget imageChild;

  const FullScreenImageViewer({Key? key, required this.imageChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4.0,
            child: imageChild,
          ),
        ),
      ),
    );
  }
}
