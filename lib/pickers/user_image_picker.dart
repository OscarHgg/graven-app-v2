import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenv2_app/theme/colors.dart';
import 'package:image_picker/image_picker.dart';

//Stateful widget because of preview
class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  //WORKS
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) return;
    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });

    //send image to auth form for cloud storage
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 60,
              backgroundColor: CustomColors.secondaryVariant,
              backgroundImage: _pickedImage != null
                  ? Image.file(_pickedImage!).image
                  : null),                  
          TextButton.icon(
            label: const Text("Lägg till bild",
                style: TextStyle(fontSize: 20, color: CustomColors.secondary)),
            icon: const Icon(
              Icons.camera_alt_rounded,
              color: CustomColors.secondary,
            ),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }
}
