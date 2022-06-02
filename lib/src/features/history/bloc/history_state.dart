part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class AllHistoryState extends HistoryState {
  final List<Delivery> delivery;

  const AllHistoryState({required this.delivery});
}

class AllHistoryErrorState extends HistoryState {
  final String error;

  const AllHistoryErrorState({required this.error});
}

class AllHistoryLoadingState extends HistoryState {}

class NoHistoryState extends HistoryState {}
