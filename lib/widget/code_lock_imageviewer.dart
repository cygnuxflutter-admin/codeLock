import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/widget/full_screen_image_viewer.dart';
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
              color: CodeLockColor.white.withOpacity(0.9), // Light title text
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: CodeLockColor.glassBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: CodeLockColor.glassBorder,
                    width: 1.2,
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // The Image or Placeholder
                    GestureDetector(
                      onTap: () => _handleImageTap(context),
                      child: _buildImageContent(),
                    ),
                    
                    // The Edit Overlay Button (only shown in Edit mode)
                    if (widget.enable.value)
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                            ),
                            child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    if (feedImageUpload != null) {
      return Image.file(
        feedImageUpload!, 
        fit: BoxFit.cover,
      );
    }
    
    // If no feedImageUpload, try to load from DB
    if (widget.getDatabaseImage.isNotEmpty && widget.getDatabaseImage != 'null') {
      return FutureBuilder<String?>(
        future: getImageAsStringFromAppDir(widget.getDatabaseImage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            String imageData = snapshot.data!;
            if (imageData.isNotEmpty) {
              try {
                Uint8List imageBytes = base64Decode(imageData);
                return Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                );
              } catch (e) {
                return _buildPlaceholder();
              }
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: CodeLockColor.accentVibrant),
            );
          }
          return _buildPlaceholder();
        },
      );
    }
    
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, color: Colors.white.withOpacity(0.4), size: 48),
          const SizedBox(height: 8),
          Text(
            widget.enable.value ? "Tap to add image" : "No image attached",
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _handleImageTap(BuildContext context) {
    detectOnTap();
    
    // If there is an image, open full screen
    bool hasDbImage = widget.getDatabaseImage.isNotEmpty && widget.getDatabaseImage != 'null';
    if (feedImageUpload != null || hasDbImage) {
       Widget imageWidget;
       if (feedImageUpload != null) {
         imageWidget = Image.file(feedImageUpload!);
       } else {
         // Pass a memory image but need to decode it first
         imageWidget = FutureBuilder<String?>(
           future: getImageAsStringFromAppDir(widget.getDatabaseImage),
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.isNotEmpty) {
               try {
                 return Image.memory(base64Decode(snapshot.data!));
               } catch(e) {
                 return const Center(child: Icon(Icons.broken_image, color: Colors.white, size: 48));
               }
             }
             return Center(child: CircularProgressIndicator(color: CodeLockColor.accentVibrant));
           },
         );
       }
       
       Get.to(() => FullScreenImageViewer(imageChild: imageWidget));
    } else {
       // If no image AND in edit mode, tapping the empty area should open picker
       if (widget.enable.value) {
         _pickImage();
       }
    }
  }

  Future<void> _pickImage() async {
    detectOnTap();
    if (!widget.enable.value) return;
    
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (image == null) return;
    File img = File(image.path);
    feedImageUpload = img;
    
    if (widget.getDatabaseImage.isNotEmpty && widget.getDatabaseImage != 'null') {
      deleteImageFromAppDir(widget.getDatabaseImage);
    }

    setState(() {
      feedImageUpload;
      final String filename_ = image.name;
      newFileName = generateFilename(filename_);

      widget.newImageName(newFileName!);
      widget.imgFile(feedImageUpload!);
    });
  }
}


