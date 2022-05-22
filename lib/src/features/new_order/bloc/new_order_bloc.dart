import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/add_order_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/recipient.dart';
import '../../../models/sender.dart';

part 'new_order_event.dart';
part 'new_order_state.dart';

class NewOrderBloc extends Bloc<NewOrderEvent, NewOrderState> {
  final AddOrderRepository repository;
  NewOrderBloc({required this.repository}) : super(NewOrderInitial()) {
    on<AddOrderEvent>(_addOrder);
    on<CheckUserInputEvent>(_checkInput);
    on<SetOrderToInitial>(_setInitial);
  }

  FutureOr<void> _addOrder(
      AddOrderEvent event, Emitter<NewOrderState> emit) async {
    final Sender _sender = event.sender;
    final Recipient _recipient = event.recipient;
    try {
      await repository.addOrder(_sender, _recipient);
      emit(AddOrderSuccess());
    } on Exception {
      emit(AddOrderError());
    }
  }

  FutureOr<void> _checkInput(
      CheckUserInputEvent event, Emitter<NewOrderState> emit) {
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
      emit(NewOrderInitial());
    } else {
      emit(StateWithButton(sender: event.sender, recipient: event.recipient));
    }
  }

  FutureOr<void> _setInitial(
      SetOrderToInitial event, Emitter<NewOrderState> emit) {
    emit(NewOrderInitial());
  }
}
