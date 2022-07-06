import 'package:cargo_bike/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../components/cargo_bike_input_field.dart';
import '../../../components/height_box.dart';
import '../../../constants/styles.dart';
import '../bloc/auth_bloc.dart';
import 'error_message.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController passwordConfirmController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _passwordConfirmController = passwordConfirmController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _passwordConfirmController;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Text(
          AppLocalizations.of(context)!.appName,
          style: CargoBikeStyle.textStyle.heading1Text,
        ),
        const HeightBox(),
        const LoginErrorMessage(),
        const HeightBox(),
        CargoBikeInputField(
          controller: widget._emailController,
          hintText: AppLocalizations.of(context)!.emailAddress,
        ),
        const HeightBox(),
        CargoBikeInputField(
          controller: widget._passwordController,
          hintText: AppLocalizations.of(context)!.password,
          hideText: true,
        ),
        const HeightBox(),
        CargoBikeInputField(
          controller: widget._passwordConfirmController,
          hintText: AppLocalizations.of(context)!.confirmPassword,
          hideText: true,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.ifCourrier),
              const SizedBox(width: 20),
              Switch(
                activeColor: CargoBikeColors.darkGreen,
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                  });
                },
              ),
            ],
          ),
        ),
        const HeightBox(),
        GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(SwitchToRegister());
            },
            child: Text(AppLocalizations.of(context)!.backToLogIn)),
        const HeightBox(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 50),
              primary: Colors.lightGreen,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(
                    RegisterEvent(
                      email: widget._emailController.text,
                      password: widget._passwordController.text,
                      confirm: widget._passwordConfirmController.text,
                      ifCourrier: _isSwitched,
                    ),
                  );
            },
            child: Text(
              AppLocalizations.of(context)!.register,
              style: CargoBikeStyle.textStyle.heading4Text,
            ))
      ]),
    );
  }
}
