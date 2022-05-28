import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CircleImage extends StatefulWidget {
  ValueChanged<File> selectedImage;
  void Function() onChange;
  CircleImage({Key? key, required this.onChange, required this.selectedImage})
      : super(key: key);

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  File? image;
  String imageUrl = '';
  void pickImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
          widget.selectedImage(this.image!);
        });
        widget.onChange();
        Navigator.pop(context);
      }
    } on PlatformException catch (e) {
      throw e.message!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                GestureDetector(
                  onTap: (() => pickImage(ImageSource.gallery)),
                  child: const ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Gallery'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickImage(ImageSource.camera);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: SizedBox(
        width: 130,
        height: 130,
        child: ClipOval(
          child: image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                )
              : imageUrl == ''
                  ? const FlutterLogo()
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }
}
