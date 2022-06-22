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
  bool? isCourrier;

  final AuthRepository repository;
  SettingsBloc({required this.repository}) : super(SettingsInitial()) {
    on<SubmitChangesEvent>(_submitChanges);
    on<GetUserInfoEvent>(_getUserInfo);
    on<CheckUserInputEvent>(_checkUserInput);
  }

  FutureOr<void> _submitChanges(
      SubmitChangesEvent event, Emitter<SettingsState> emit) async {
    try {
      print(event.user.isCourrier.toString());
      await repository.saveUserInfo(event.user, event.image);
      emit(UserSavedSuccessState());
    } on Exception {
      emit(ErrorState());
    }
  }

  FutureOr<void> _getUserInfo(event, Emitter<SettingsState> emit) async {
    emit(UserLoadingState());
    UserModel? user;
    try {
      user = await repository.getUserInfo();
      userFName = user.firstName;
      userLName = user.lastName;
      userAddress = user.address;
      userPhone = user.phone;
      imageUrl = user.imageUrl;
      isCourrier = user.isCourrier;
    } catch (e) {
      user = null;
    }
    if (user != null) {
      emit(UserLoadedState(user: user));
    } else if (user == null) {
      emit(UserLoadedState(
          user: UserModel(
        address: '',
        firstName: '',
        lastName: '',
        phone: '',
        imageUrl: '',
        isCourrier: user?.isCourrier,
      )));
    } else {
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
              phone: event.user.phone,
              isCourrier: event.user.isCourrier)));
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
