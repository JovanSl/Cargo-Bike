part of 'delivery_details_bloc.dart';

abstract class DeliveryDetailsState extends Equatable {
  const DeliveryDetailsState();

  @override
  List<Object> get props => [];
}

class DeliveryDetailsInitial extends DeliveryDetailsState {}

class DeleteDeliveryLoadingState extends DeliveryDetailsState {}

class DeleteDeliveryErrorState extends DeliveryDetailsState {}

class DeleteDeliverySuccessState extends DeliveryDetailsState {}
