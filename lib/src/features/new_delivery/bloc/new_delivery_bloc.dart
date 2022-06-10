import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

import '../../../models/recipient.dart';
import '../../../models/sender.dart';
import '../../../models/location.dart' as loc;

part 'new_delivery_event.dart';
part 'new_delivery_state.dart';

class NewDeliveryBloc extends Bloc<NewDeliveryEvent, NewDeliveryState> {
  final DeliveryRepository repository;
  NewDeliveryBloc({required this.repository}) : super(NewDeliveryInitial()) {
    on<AddDeliveryEvent>(_addDelivery);
    on<CheckUserInputEvent>(_checkInput);
    on<SetDeliveryToInitial>(_setInitial);
  }

  FutureOr<void> _addDelivery(
      AddDeliveryEvent event, Emitter<NewDeliveryState> emit) async {
    List<Location> locations = [];
    try {
      locations =
          await getLocations(event.sender.address, event.recipient.address);
    } catch (e) {
      emit(BadAddressState());
    }
    if (locations.isNotEmpty) {
      try {
        await repository.addDelivery(
            Sender(
              name: event.sender.name,
              email: event.sender.email,
              phone: event.sender.phone,
              address: event.sender.address,
              location: loc.Location(
                  lat: locations.first.latitude,
                  lng: locations.first.longitude),
            ),
            Recipient(
              name: event.recipient.name,
              additionalInfo: event.recipient.additionalInfo,
              phone: event.recipient.phone,
              address: event.recipient.address,
              location: loc.Location(
                  lat: locations.last.latitude, lng: locations.last.longitude),
            ));
        emit(AddDeliverySuccess());
      } on Exception {
        emit(AddDeliveryError());
      }
    } else {
      emit(BadAddressState());
    }
  }

  FutureOr<void> _checkInput(
      CheckUserInputEvent event, Emitter<NewDeliveryState> emit) {
    String? senderEmail = event.sender.email;
    String? senderPhone = event.sender.phone;
    String? senderName = event.sender.name;
    String? senderAddress = event.sender.address;
    String? recipientAdditionalInfo = event.recipient.additionalInfo;
    String? recipientPhone = event.recipient.phone;
    String? recipientName = event.recipient.name;
    String? recipientAddress = event.recipient.address;

    if (senderEmail.isEmpty ||
        senderAddress.isEmpty ||
        senderName.isEmpty ||
        senderPhone.isEmpty ||
        recipientAdditionalInfo.isEmpty ||
        recipientName.isEmpty ||
        recipientPhone.isEmpty ||
        recipientAddress.isEmpty) {
      emit(NewDeliveryInitial());
    } else {
      emit(StateWithButton(sender: event.sender, recipient: event.recipient));
    }
  }

  FutureOr<void> _setInitial(
      SetDeliveryToInitial event, Emitter<NewDeliveryState> emit) {
    emit(NewDeliveryInitial());
  }

  Future getLocations(location1, location2) async {
    List<Location> x = [];
    x.addAll(await locationFromAddress(location1));
    x.addAll(await locationFromAddress(location2));
    return x;
  }
}
