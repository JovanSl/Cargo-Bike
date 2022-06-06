import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cargo_bike/src/repositories/delivery_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/delivery.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final DeliveryRepository repository;
  HistoryBloc({required this.repository}) : super(HistoryInitial()) {
    on<GetHistoryEvent>(_getHistory);
  }

  FutureOr<void> _getHistory(
      GetHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(AllHistoryLoadingState());
    try {
      List<Delivery> deliveries = await repository.getHistory();
      if (deliveries.isEmpty) {
        emit(NoHistoryState());
      } else {
        emit(AllHistoryState(delivery: deliveries));
      }
    } catch (e) {
      emit(const AllHistoryErrorState(error: 'An Error occured'));
    }
  }
}
