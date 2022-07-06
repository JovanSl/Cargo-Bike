import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../components/cargo_bike_input_field.dart';
import '../../../components/height_box.dart';
import '../../../constants/styles.dart';
import '../bloc/auth_bloc.dart';
import 'error_message.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Text(AppLocalizations.of(context)!.appName,
            style: CargoBikeStyle.textStyle.heading1Text),
        const HeightBox(),
        const LoginErrorMessage(),
        const HeightBox(),
        CargoBikeInputField(
          controller: _emailController,
          hintText: AppLocalizations.of(context)!.emailAddress,
        ),
        const HeightBox(),
        CargoBikeInputField(
          controller: _passwordController,
          hintText: AppLocalizations.of(context)!.password,
          hideText: true,
        ),
        const HeightBox(),
        GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(SwitchToRegister());
            },
            child: Text(AppLocalizations.of(context)!.registerForm)),
        const HeightBox(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(120, 50),
              primary: Colors.lightGreen,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(
                    LogInEvent(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
            },
            child: Text(
              AppLocalizations.of(context)!.logIn,
              style: CargoBikeStyle.textStyle.heading4Text,
            ))
      ]),
    );
  }
}
