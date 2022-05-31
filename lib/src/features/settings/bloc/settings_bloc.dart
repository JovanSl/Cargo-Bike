import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/user.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  String? userFName;
  String? userLName;
  String? userAddress;
  String? userPhone;
  String? imageUrl;

  final AuthRepository repository;
  SettingsBloc({required this.repository}) : super(SettingsInitial()) {
    on<SubmitChangesEvent>(_submitChanges);
    on<GetUserInfoEvent>(_getUserInfo);
    on<CheckUserInputEvent>(_checkUserInput);
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
      userFName = user.firstName;
      userLName = user.lastName;
      userAddress = user.address;
      userPhone = user.phone;
      imageUrl = user.imageUrl;
      emit(UserLoadedState(user: user));
    } catch (e) {
      emit(ErrorState());
    }
  }

  FutureOr<void> _checkUserInput(
      CheckUserInputEvent event, Emitter<SettingsState> emit) async {
    if (event.user.firstName != userFName ||
        event.user.lastName != userLName ||
        event.user.imageUrl != imageUrl ||
        event.image != null ||
        event.user.address != userAddress ||
        event.user.phone != userPhone) {
      emit(UserButtonState(
          user: UserModel(
              firstName: event.user.firstName,
              lastName: event.user.lastName,
              imageUrl: event.user.imageUrl!,
              address: event.user.address,
              phone: event.user.phone)));
    } else {
      emit(UserLoadedState(
          user: UserModel(
              firstName: userFName,
              lastName: userLName,
              phone: userPhone,
              address: userAddress,
              imageUrl: imageUrl)));
    }
  }
}
