part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class ErrorState extends SettingsState {}

class UserLoadingState extends SettingsState {}

class UserLoadedState extends SettingsState {
  final UserModel user;

  const UserLoadedState({required this.user});
}

class UserButtonState extends SettingsState {
  final UserModel user;

  const UserButtonState({required this.user});
}

class UserSavedSuccessState extends SettingsState {}
