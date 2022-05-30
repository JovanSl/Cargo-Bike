import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings_controller.dart';

class DropDown extends StatefulWidget {
  final SettingsController controller;
  const DropDown({Key? key, required this.controller}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  Map<String, String> lang = {'en': 'English', 'sr': 'Srpski'};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButton<ThemeMode>(
            value: widget.controller.themeMode,
            onChanged: widget.controller.updateThemeMode,
            items: [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text(AppLocalizations.of(context)!.systemTheme),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text(AppLocalizations.of(context)!.lightTheme),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text(AppLocalizations.of(context)!.darkTheme),
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
            value: widget.controller.locale.languageCode,
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
            onChanged: (value) => widget.controller.updateLocale(value!),
          ),
        ),
      ],
    );
  }
}
