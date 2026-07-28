import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/image/code_lock_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    Key? key,
    required this.titleText,
    required this.imageName,
    required this.imgFile,
  }) : super(key: key);

  final String titleText;
  final void Function(String imgName) imageName;
  final void Function(File filename) imgFile;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  File? feedImageUpload;
  ImagePicker picker = ImagePicker();
  String? newImageName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: CodeLockColor.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              detectOnTap();
              XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
                preferredCameraDevice: CameraDevice.rear,
                imageQuality: 60,
                maxWidth: 1200,
                maxHeight: 1200,
              );

              if (image == null) return;
              File img = File(image.path);
              feedImageUpload = img;

              setState(() {
                feedImageUpload;
                final String filename_ = image.name;
                newImageName = generateFilename(filename_);

                widget.imageName(newImageName!);
                widget.imgFile(feedImageUpload!);
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: context.getHeight * 0.2,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: CodeLockColor.glassBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: CodeLockColor.glassBorder,
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CodeLockColor.accentVibrant,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        width: 4.5,
                      ),
                      Expanded(
                        child: Center(
                          child: feedImageUpload != null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(feedImageUpload!, height: double.infinity, fit: BoxFit.cover),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 48,
                                      color: CodeLockColor.white.withOpacity(0.6),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Choose Image File",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: CodeLockColor.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String generateFilename(String filename) {
  List<String> parts = filename.split('.');
  String name = parts.first;
  String extension = parts.last;
  String finalName =
      '${name}_${DateTime.now().microsecondsSinceEpoch}.$extension';
  return finalName;
}

Future<void> saveImageToAppDir(List<int> imageBytes, String filename) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String folderPath = '${appDir.path}/app_data';
  final String filePath = '$folderPath/$filename';
  final File file = File(filePath);
  await file.writeAsBytes(imageBytes);
}

Future<String?> getImageAsStringFromAppDir(String filename) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String filePath = '${appDir.path}/app_data/$filename';
  final File file = File(filePath);

  if (await file.exists()) {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  } else {
    return null;
  }
}

Future<void> deleteImageFromAppDir(String filename) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final String filePath = '${appDir.path}/app_data/$filename';
  final File file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }
}
