import 'dart:io';

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/settings/components/circle_image.dart';
import 'package:cargo_bike/src/features/settings/components/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../authentication/bloc/auth_bloc.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    File? image;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CargoBikeColors.lightGreen,
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
      ),
      body: Column(
        children: [
          CircleImage(
            selectedImage: (value) {
              image = value;
            },
            onChange: () {},
          ),
          DropDown(controller: controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogOutEvent());
                  },
                  child: Text(AppLocalizations.of(context)!.logout)),
            ],
          )
        ],
      ),
    );
  }
}
