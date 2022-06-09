import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/models/delivery.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';

part 'main_list_event.dart';
part 'main_list_state.dart';

class MainListBloc extends Bloc<MainListEvent, MainListState> {
  final DeliveryRepository repository;
  MainListBloc({required this.repository}) : super(MainListInitial()) {
    on<GetAllDeliveries>(_getDeliveries);
  }

  FutureOr<void> _getDeliveries(event, Emitter<MainListState> emit) async {
    emit(AllDeliveriesLoadingState());
    try {
      List<Delivery> deliveries = await repository.getActiveDeliveries();
      if (deliveries.isEmpty) {
        emit(NoDeliveriesState());
      } else {
        emit(AllDeliveriesState(delivery: deliveries));
      }
    } catch (e) {
      emit(const AllDeliveriesErrorState(error: 'An Error occured'));
    }
  }
}
