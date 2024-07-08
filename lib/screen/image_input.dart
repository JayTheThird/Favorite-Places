import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  bool _isImageSelected = false;

  void takePicture() async {
    final imagePicker = ImagePicker();
    final takeImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxWidth: double.infinity,
    );

    if (takeImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(takeImage.path);
      _isImageSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: _isImageSelected
          ? GestureDetector(
              onTap: takePicture,
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          : TextButton.icon(
              onPressed: takePicture,
              label: const Text("Camera"),
              icon: const Icon(Icons.camera_alt_outlined),
            ),
    );
  }
}
