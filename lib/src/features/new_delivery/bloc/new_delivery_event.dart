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
  final String senderAddress;
  final String recipientAddress;

  const AddDeliveryEvent(this.senderAddress, this.recipientAddress,
      {required this.sender, required this.recipient});
}

class CheckUserInputEvent extends NewDeliveryEvent {
  final Sender sender;
  final Recipient recipient;
  final String? senderAddress;
  final String? recipientAddress;

  const CheckUserInputEvent(this.senderAddress, this.recipientAddress,
      {required this.sender, required this.recipient});
}

class SuggestAddress extends NewDeliveryEvent {
  final String address;

  const SuggestAddress({required this.address});
}

class AddressLoaded extends NewDeliveryEvent {
  final List<Properties?> suggestions;

  const AddressLoaded({required this.suggestions});
}
