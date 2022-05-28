import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/recipient.dart';
import '../../../models/sender.dart';

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
    final Sender _sender = event.sender;
    final Recipient _recipient = event.recipient;
    try {
      await repository.addDelivery(_sender, _recipient);
      emit(AddDeliverySuccess());
    } on Exception {
      emit(AddDeliveryError());
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
}
