import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/utils/password_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<RegisterEvent>(_register);
    on<LogInEvent>(_logIn);
    on<CheckUserStatusEvent>(_checkUserStatus);
    on<LogOutEvent>(_logOut);
    on<SwitchToRegister>(_switchToRegister);
  }

  Future<void> _checkUserStatus(
      CheckUserStatusEvent event, Emitter<AuthState> emit) async {
    final isSignedIn = await repository.isSignedIn();

    if (isSignedIn) {
      emit(RegisterSuccessState());
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    if (event.email.isEmpty ||
        event.password.isEmpty ||
        event.confirm.isEmpty) {
      emit(const RegisterErrorState(error: 'All fields must be filled'));
    } else if (event.password != event.confirm) {
      emit(const RegisterErrorState(error: 'Passwords must match'));
    } else if (PasswordValidator().call(event.password).message != '') {
      emit(RegisterErrorState(
          error: PasswordValidator().call(event.password).message));
    } else {
      try {
        await repository.signUpWithCredentials(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(RegisterErrorState(error: e.message));
      }
    }
  }

  Future<void> _logIn(LogInEvent event, Emitter<AuthState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const LoginErrorState(error: 'Email or password can\'t be empty'));
    } else {
      try {
        await repository.logInWithCredentials(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(error: e.message));
      }
    }
  }

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    await repository.signOut();
    emit(UnauthenticatedState());
  }

  FutureOr<void> _switchToRegister(
      SwitchToRegister event, Emitter<AuthState> emit) {
    if (state is RegisterState || state is RegisterErrorState) {
      emit(UnauthenticatedState());
    } else {
      emit(RegisterState());
    }
  }
}
