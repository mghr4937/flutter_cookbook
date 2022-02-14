import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

typedef OnImageSelected = void Function(File imageFile);

class ImagePickerWidget extends StatelessWidget {
  final File imageFile;
  final OnImageSelected onImageSelected;
  final ImagePicker imagePicker = ImagePicker();

  ImagePickerWidget(
      {Key key, @required this.imageFile, @required this.onImageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[700],
              Colors.deepPurple[800],
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          image: imageFile != null
              ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover)
              : null),
      child: IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () {
          _showPickerOptions(context);
        },
        iconSize: 90,
        color: Colors.white,
      ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camara"),
              onTap: () {
                Navigator.pop(context);
                _showPickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Galería"),
              onTap: () {
                Navigator.pop(context);
                _showPickImage(context, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPickImage(BuildContext context, source) async {
    var image = await imagePicker.pickImage(source: source);
    onImageSelected(File(image.path));
  }
}
