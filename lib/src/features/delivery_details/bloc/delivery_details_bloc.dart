import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';

part 'delivery_details_event.dart';
part 'delivery_details_state.dart';

class DeliveryDetailsBloc
    extends Bloc<DeliveryDetailsEvent, DeliveryDetailsState> {
  final DeliveryRepository repository;
  DeliveryDetailsBloc({required this.repository})
      : super(DeliveryDetailsInitial()) {
    on<DeleteDeliveryEvent>(_deleteDelivery);
  }

  FutureOr<void> _deleteDelivery(event, Emitter<DeliveryDetailsState> emit) {
    emit(DeleteDeliveryLoadingState());
    try {
      repository.removeDelivery(event.id);
      emit(DeleteDeliverySuccessState());
    } catch (e) {
      emit(DeleteDeliveryErrorState());
    }
  }
}
