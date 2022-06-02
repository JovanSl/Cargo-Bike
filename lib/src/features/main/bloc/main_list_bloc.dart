import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/models/delivery.dart';
import 'package:cargo_bike/src/repositories/auth_repository.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';

part 'main_list_event.dart';
part 'main_list_state.dart';

class MainListBloc extends Bloc<MainListEvent, MainListState> {
  final DeliveryRepository repository;
  final AuthRepository auth;
  MainListBloc({required this.auth, required this.repository})
      : super(MainListInitial()) {
    on<GetAllDeliveries>(_getDeliveries);
  }

  FutureOr<void> _getDeliveries(event, Emitter<MainListState> emit) async {
    emit(AllDeliveriesLoadingState());
    List<Delivery> myDeliveries = [];
    var userId = await auth.getUserId();
    try {
      List<Delivery> deliveries = await repository.getDeliveries();

      for (var element in deliveries) {
        if (element.userId == userId) {
          myDeliveries.add(element);
        }
      }
      if (myDeliveries.isEmpty) {
        emit(NoDeliveriesState());
      } else {
        emit(AllDeliveriesState(delivery: myDeliveries));
      }
    } catch (e) {
      emit(const AllDeliveriesErrorState(error: 'An Error occured'));
    }
  }
}
