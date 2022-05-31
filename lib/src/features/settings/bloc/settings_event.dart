part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SubmitChangesEvent extends SettingsEvent {
  final UserModel user;
  final File? image;
  const SubmitChangesEvent(this.user, this.image);

  @override
  List<Object> get props => [user, image ?? image!];
}

class GetUserInfoEvent extends SettingsEvent {}
