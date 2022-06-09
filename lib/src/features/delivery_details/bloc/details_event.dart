part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadMapEvent extends DetailsEvent {
  final String senderAddress;
  final String recipiantAddress;

  const LoadMapEvent(this.senderAddress, this.recipiantAddress);
}

class InitialMapEvent extends DetailsEvent {}
