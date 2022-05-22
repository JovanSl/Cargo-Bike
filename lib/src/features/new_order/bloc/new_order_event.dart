part of 'new_order_bloc.dart';

abstract class NewOrderEvent extends Equatable {
  const NewOrderEvent();

  @override
  List<Object> get props => [];
}

class SetOrderToInitial extends NewOrderEvent {}

class AddOrderEvent extends NewOrderEvent {
  final Sender sender;
  final Recipient recipient;

  const AddOrderEvent({required this.sender, required this.recipient});
}

class CheckUserInputEvent extends NewOrderEvent {
  final Sender sender;
  final Recipient recipient;

  const CheckUserInputEvent({required this.sender, required this.recipient});
}
