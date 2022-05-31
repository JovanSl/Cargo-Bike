import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/user.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthRepository repository;
  SettingsBloc({required this.repository}) : super(SettingsInitial()) {
    on<SubmitChangesEvent>(_submitChanges);
    on<GetUserInfoEvent>(_getUserInfo);
  }

  FutureOr<void> _submitChanges(
      SubmitChangesEvent event, Emitter<SettingsState> emit) async {
    try {
      await repository.saveUserInfo(event.user, event.image);
      emit(UserSavedSuccessState());
    } on Exception {
      emit(ErrorState());
    }
  }

  FutureOr<void> _getUserInfo(event, Emitter<SettingsState> emit) async {
    emit(UserLoadingState());
    try {
      UserModel user = await repository.getUserInfo();
      emit(UserLoadedState(user: user));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
