import 'dart:io';

import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/features/settings/components/circle_image.dart';
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

    Map<String, String> lang = {'en': 'English', 'sr': 'Srpski'};
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<ThemeMode>(
              value: controller.themeMode,
              onChanged: controller.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              iconSize: 30,
              hint: SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.language,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              value: controller.locale.languageCode,
              items: lang
                  .map(
                    (key, value) {
                      return MapEntry(
                        key,
                        DropdownMenuItem<String>(
                          value: key,
                          child: SizedBox(
                            child: Text(
                              value,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
              onChanged: (value) => controller.updateLocale(value!),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogOutEvent());
                  },
                  child: const Text('LOGOUT')),
            ],
          )
        ],
      ),
    );
  }
}
