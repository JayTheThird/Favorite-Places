import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
      ),
      child: TextButton.icon(
        onPressed: () {},
        label: const Text("Camera"),
        icon: const Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}
