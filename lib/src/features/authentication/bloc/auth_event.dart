part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirm;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.confirm,
  });

  @override
  List<Object> get props => [email, password, confirm];
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  const LogInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogOutEvent extends AuthEvent {}

class CheckUserStatusEvent extends AuthEvent {}

class SwitchToRegister extends AuthEvent {}
