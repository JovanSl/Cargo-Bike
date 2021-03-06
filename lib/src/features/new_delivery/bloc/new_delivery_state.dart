part of 'new_delivery_bloc.dart';

abstract class NewDeliveryState extends Equatable {
  const NewDeliveryState();

  @override
  List<Object> get props => [];
}

class AddDeliverySuccess extends NewDeliveryState {}

class NewDeliveryInitial extends NewDeliveryState {}

class StateWithButton extends NewDeliveryState {
  final Sender sender;
  final Recipient recipient;

  const StateWithButton({required this.sender, required this.recipient});
}

class AddDeliveryError extends NewDeliveryState {}

class BadAddressState extends NewDeliveryState {}

class SuggestAddressState extends NewDeliveryState {
  final List<Properties?> suggestion;
  final String form;

  const SuggestAddressState({required this.suggestion, required this.form});
}
