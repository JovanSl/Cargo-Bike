import 'package:cargo_bike/src/constants/styles.dart';
import 'package:cargo_bike/src/features/authentication/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/error_message.dart';
import 'components/login_input_field.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is LoginState ||
                  state is UnauthenticatedState ||
                  state is LoginErrorState) {
                return Center(
                  child: Column(children: <Widget>[
                    Text('Login Form',
                        style: CargoBikeStyle.textStyle.heading1Text),
                    const SizedBox(
                      height: 20,
                    ),
                    const LoginErrorMessage(),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginInputField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginInputField(
                      controller: _passwordController,
                      hintText: 'Password',
                      hideText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(SwitchToRegister());
                        },
                        child: const Text('Register')),
                    const SizedBox(
                      height: 20,
                    ),
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
                          'Log In',
                          style: CargoBikeStyle.textStyle.heading4Text,
                        ))
                  ]),
                );
              } else if (state is RegisterState ||
                  state is RegisterErrorState) {
                return Center(
                  child: Column(children: <Widget>[
                    Text(
                      'Register Form',
                      style: CargoBikeStyle.textStyle.heading1Text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const LoginErrorMessage(),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginInputField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginInputField(
                      controller: _passwordController,
                      hintText: 'Password',
                      hideText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginInputField(
                      controller: _passwordConfirmController,
                      hintText: 'Confirm Password',
                      hideText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(SwitchToRegister());
                        },
                        child: const Text('Back to login')),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120, 50),
                          primary: Colors.lightGreen,
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                RegisterEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  confirm: _passwordConfirmController.text,
                                ),
                              );
                        },
                        child: Text(
                          'Register',
                          style: CargoBikeStyle.textStyle.heading4Text,
                        ))
                  ]),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
