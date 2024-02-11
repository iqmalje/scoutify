import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CropCirclePicturePage extends StatefulWidget {
  final XFile file;
  CropCirclePicturePage({super.key, required this.file});

  @override
  State<CropCirclePicturePage> createState() =>
      _CropCirclePicturePageState(file);
}

class _CropCirclePicturePageState extends State<CropCirclePicturePage> {
  XFile file;
  _CropCirclePicturePageState(this.file);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
