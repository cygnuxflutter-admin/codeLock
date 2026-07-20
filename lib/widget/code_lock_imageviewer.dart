import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'code_lock_imagepicker.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({
    Key? key,
    required this.titleText,
    required this.getDatabaseImage,
    required this.newImageName,
    required this.imgFile,
    required this.enable,
  }) : super(key: key);

  final String titleText;
  final String getDatabaseImage;
  final void Function(String imgName) newImageName;
  final void Function(File filename) imgFile;
  final RxBool enable;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  File? feedImageUpload;
  ImagePicker picker = ImagePicker();
  String? newFileName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          detectOnTap();
          if (widget.enable.value) {
            XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
              preferredCameraDevice: CameraDevice.rear,
            );

            if (image == null) return;
            File img = File(image.path);
            feedImageUpload = img;
            deleteImageFromAppDir(widget.getDatabaseImage);

            // Directory documentsDirectory = await getApplicationDocumentsDirectory();
            // String documentPath = documentsDirectory.path;
            // print(documentPath);

            setState(() {
              feedImageUpload;
              final String filename_ = image.name;
              newFileName = generateFilename(filename_);

              widget.newImageName(newFileName!);
              widget.imgFile(feedImageUpload!);

            });
          }
        },
        child: Center(
            child: feedImageUpload == null
                ? FutureBuilder<String?>(
                    future: getImageAsStringFromAppDir(widget.getDatabaseImage),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        String imageData = snapshot.data!;
                        Uint8List imageBytes = base64Decode(imageData);
                        return Image.memory(
                          imageBytes,
                          height: 100,
                        );
                      } else {
                        return const Text('Loading image...');
                      }
                    },
                  )
                : Image.file(feedImageUpload!, height: 100)));
  }
}

Future<void> deleteImageFromAppDir(String filename) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String filePath = '${appDir.path}/image_folder/$filename';
  final File file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }
}
