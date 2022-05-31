import 'dart:io';

import 'package:cargo_bike/src/components/progress_indicator.dart';
import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/constants/styles.dart';
import 'package:cargo_bike/src/components/cargo_bike_input_field.dart';
import 'package:cargo_bike/src/features/settings/bloc/settings_bloc.dart';
import 'package:cargo_bike/src/features/settings/components/circle_image.dart';
import 'package:cargo_bike/src/features/settings/components/drop_down.dart';
import 'package:cargo_bike/src/models/user.dart';
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
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController address = TextEditingController();
    final TextEditingController phone = TextEditingController();
    String imageUrl = '';
    File? image;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(LogOutEvent());
                  },
                  child: Text(
                    AppLocalizations.of(context)!.logout,
                    style: CargoBikeStyle.textStyle.errorText
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
            ),
          ),
        ],
        backgroundColor: CargoBikeColors.lightGreen,
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is UserSavedSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Successfuly saved user info')));
              context.read<SettingsBloc>().add(GetUserInfoEvent());
            }
          },
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const CargoBikeProgressIndicator();
            } else if (state is UserLoadedState) {
              firstName.text = state.user.firstName!;
              address.text = state.user.address!;
              lastName.text = state.user.lastName!;
              phone.text = state.user.phone!;
              imageUrl = state.user.imageUrl ?? '';
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleImage(
                    selectedImage: (value) {
                      image = value;
                    },
                    onChange: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CargoBikeInputField(
                    controller: firstName,
                    hintText: AppLocalizations.of(context)!.name,
                    hideText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CargoBikeInputField(
                    controller: lastName,
                    hintText: AppLocalizations.of(context)!.lastName,
                    hideText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CargoBikeInputField(
                    controller: phone,
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                    hideText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CargoBikeInputField(
                    controller: address,
                    hintText: AppLocalizations.of(context)!.receptionAddress,
                    hideText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropDown(controller: controller),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<SettingsBloc>().add(SubmitChangesEvent(
                                UserModel(
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  address: address.text,
                                  phone: phone.text,
                                  imageUrl: imageUrl,
                                ),
                                image));
                          },
                          child: Text(AppLocalizations.of(context)!.submit)),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
