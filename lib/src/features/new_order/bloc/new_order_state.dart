part of 'new_order_bloc.dart';

abstract class NewOrderState extends Equatable {
  const NewOrderState();

  @override
  List<Object> get props => [];
}

class AddOrderSuccess extends NewOrderState {}

class NewOrderInitial extends NewOrderState {}

class StateWithButton extends NewOrderState {
  final Sender sender;
  final Recipient recipient;

  const StateWithButton({required this.sender, required this.recipient});
}

class AddOrderError extends NewOrderState {}
