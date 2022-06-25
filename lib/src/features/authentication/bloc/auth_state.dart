part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends AuthState {}

class UnauthenticatedState extends AuthState {}

class AuthInitial extends AuthState {}

class LoginState extends AuthState {}

class RegisterState extends AuthState {}

class NotVerifiedEmailState extends AuthState {}

class LoginErrorState extends AuthState {
  final String? error;

  const LoginErrorState({
    this.error,
  });

  @override
  List<Object> get props => [error!];
}

class RegisterErrorState extends AuthState {
  final String? error;

  const RegisterErrorState({
    this.error,
  });

  @override
  List<Object> get props => [error!];
}
