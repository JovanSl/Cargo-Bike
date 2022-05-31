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
    on<GetAllOrders>(_getOrders);
  }

  FutureOr<void> _getOrders(event, Emitter<MainListState> emit) async {
    emit(AllOrdersLoadingState());
    try {
      List<Delivery> _orders = await repository.getDeliveries();
      emit(AllOrdersState(order: _orders));
    } catch (e) {
      emit(const AllOrdersErrorState(error: 'An Error occured'));
    }
  }
}
