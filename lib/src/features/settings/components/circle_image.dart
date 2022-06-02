import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/settings_bloc.dart';

// ignore: must_be_immutable
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
                  child: ListTile(
                    leading: const Icon(Icons.photo),
                    title: Text(AppLocalizations.of(context)!.gallery),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickImage(ImageSource.camera);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text(AppLocalizations.of(context)!.camera),
                  ),
                ),
              ],
            );
          },
        );
      },
      child:
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        if (state is UserLoadedState) {
          imageUrl = state.user.imageUrl ?? '';
        }
        return SizedBox(
          width: 130,
          height: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
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
        );
      }),
    );
  }
}
