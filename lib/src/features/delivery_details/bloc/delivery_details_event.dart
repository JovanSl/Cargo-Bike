part of 'delivery_details_bloc.dart';

abstract class DeliveryDetailsEvent extends Equatable {
  const DeliveryDetailsEvent();

  @override
  List<Object> get props => [];
}

class DeleteDeliveryEvent extends DeliveryDetailsEvent {
  final String id;

  const DeleteDeliveryEvent({required this.id});
}
