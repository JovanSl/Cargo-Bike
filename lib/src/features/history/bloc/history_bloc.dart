import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/delivery.dart';
import '../../../repositories/auth_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final DeliveryRepository repository;
  final AuthRepository auth;
  HistoryBloc({required this.auth, required this.repository})
      : super(HistoryInitial()) {
    on<GetHistoryEvent>(_getHistory);
  }

  FutureOr<void> _getHistory(
      GetHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(AllHistoryLoadingState());
    List<Delivery> myHistory = [];
    var userId = await auth.getUserId();
    try {
      List<Delivery> deliveries = await repository.getDeliveries();

      for (var element in deliveries) {
        if (element.userId == userId) {
          if (element.status == 'done') {
            myHistory.add(element);
          }
        }
      }
      if (myHistory.isEmpty) {
        emit(NoHistoryState());
      } else {
        emit(AllHistoryState(delivery: myHistory));
      }
    } catch (e) {
      emit(const AllHistoryErrorState(error: 'An Error occured'));
    }
  }
}
