import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/styles.dart';
import '../bloc/auth_bloc.dart';

class LoginErrorMessage extends StatelessWidget {
  const LoginErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is UnauthenticatedState || state is RegisterState) {
        const SizedBox();
      }
      if (state is RegisterErrorState) {
        return ErrorTextPadding(state.error!);
      } else if (state is LoginErrorState) {
        return ErrorTextPadding(state.error!);
      }

      return const SizedBox();
    });
  }
}

class ErrorTextPadding extends StatelessWidget {
  final String? error;
  const ErrorTextPadding(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        error!, //state.error!,
        style: CargoBikeStyle.textStyle.errorText,
        textAlign: TextAlign.left,
      ),
    );
  }
}
