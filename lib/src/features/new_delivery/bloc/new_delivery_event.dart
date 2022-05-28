part of 'new_delivery_bloc.dart';

abstract class NewDeliveryEvent extends Equatable {
  const NewDeliveryEvent();

  @override
  List<Object> get props => [];
}

class SetDeliveryToInitial extends NewDeliveryEvent {}

class AddDeliveryEvent extends NewDeliveryEvent {
  final Sender sender;
  final Recipient recipient;

  const AddDeliveryEvent({required this.sender, required this.recipient});
}

class CheckUserInputEvent extends NewDeliveryEvent {
  final Sender sender;
  final Recipient recipient;

  const CheckUserInputEvent({required this.sender, required this.recipient});
}
