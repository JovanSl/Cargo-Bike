import 'dart:io';

import 'package:cargo_bike/src/components/input_field_component.dart';
import 'package:cargo_bike/src/components/progress_indicator.dart';
import 'package:cargo_bike/src/constants/colors.dart';
import 'package:cargo_bike/src/constants/styles.dart';
import 'package:cargo_bike/src/features/settings/bloc/settings_bloc.dart';
import 'package:cargo_bike/src/features/settings/components/circle_image.dart';
import 'package:cargo_bike/src/features/settings/components/drop_down.dart';
import 'package:cargo_bike/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/logout_alert_dialog.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.controller}) : super(key: key);
  static const routeName = '/settings';
  final SettingsController controller;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  bool? _isCourrier;
  bool visible = false;
  String imageUrl = '';
  File? image;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    address.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                  onTap: () => logoutDialog(context),
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(AppLocalizations.of(context)!.userInfoSaveSuccess)));
              context.read<SettingsBloc>().add(GetUserInfoEvent());
            }
          },
          builder: (context, state) {
            if (state is ErrorState) {
              return Text(AppLocalizations.of(context)!.error);
            }
            if (state is UserLoadingState) {
              return const CargoBikeProgressIndicator();
            } else if (state is UserLoadedState || state is UserButtonState) {
              if (state is UserLoadedState) {
                firstName.text = state.user.firstName!;
                address.text = state.user.address!;
                lastName.text = state.user.lastName!;
                phone.text = state.user.phone!;
                imageUrl = state.user.imageUrl ?? '';
                visible = false;
                _isCourrier = state.user.isCourrier;
              }
              if (state is UserButtonState) {
                firstName.text = state.user.firstName!;
                address.text = state.user.address!;
                lastName.text = state.user.lastName!;
                phone.text = state.user.phone!;
                imageUrl = state.user.imageUrl ?? '';
                visible = true;
                _isCourrier = state.user.isCourrier;
              }
            }
            return Form(
              onChanged: () {
                context.read<SettingsBloc>().add(
                      CheckUserInputEvent(
                          UserModel(
                            firstName: firstName.text,
                            lastName: lastName.text,
                            address: address.text,
                            phone: phone.text,
                            imageUrl: imageUrl,
                            isCourrier: _isCourrier,
                          ),
                          image),
                    );
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CircleImage(
                    selectedImage: (value) {
                      image = value;
                    },
                    onChange: () {
                      context.read<SettingsBloc>().add(
                            CheckUserInputEvent(
                                UserModel(
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  address: address.text,
                                  phone: phone.text,
                                  imageUrl: imageUrl,
                                  isCourrier: _isCourrier,
                                ),
                                image),
                          );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputFieldComponent(
                      controller: firstName,
                      lable: AppLocalizations.of(context)!.name),
                  InputFieldComponent(
                      controller: lastName,
                      lable: AppLocalizations.of(context)!.lastName),
                  InputFieldComponent(
                      controller: phone,
                      lable: AppLocalizations.of(context)!.phoneNumber),
                  InputFieldComponent(
                      controller: address,
                      lable: AppLocalizations.of(context)!.receptionAddress),
                  DropDown(controller: widget.controller),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: visible,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 35),
                              primary: Colors.lightGreen,
                            ),
                            onPressed: () {
                              context
                                  .read<SettingsBloc>()
                                  .add(SubmitChangesEvent(
                                      UserModel(
                                        firstName: firstName.text,
                                        lastName: lastName.text,
                                        address: address.text,
                                        phone: phone.text,
                                        imageUrl: imageUrl,
                                        isCourrier: _isCourrier,
                                      ),
                                      image));
                            },
                            child: Text(AppLocalizations.of(context)!.submit)),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
