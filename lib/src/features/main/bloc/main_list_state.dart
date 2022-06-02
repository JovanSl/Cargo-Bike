part of 'main_list_bloc.dart';

abstract class MainListState extends Equatable {
  const MainListState();

  @override
  List<Object> get props => [];
}

class MainListInitial extends MainListState {}

class AllDeliveriesState extends MainListState {
  final List<Delivery> delivery;

  const AllDeliveriesState({required this.delivery});
}

class AllDeliveriesErrorState extends MainListState {
  final String error;

  const AllDeliveriesErrorState({required this.error});
}

class AllDeliveriesLoadingState extends MainListState {}

class NoDeliveriesState extends MainListState {}
