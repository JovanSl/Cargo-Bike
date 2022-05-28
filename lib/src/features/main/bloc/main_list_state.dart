part of 'main_list_bloc.dart';

abstract class MainListState extends Equatable {
  const MainListState();

  @override
  List<Object> get props => [];
}

class MainListInitial extends MainListState {}

class AllOrdersState extends MainListState {
  final List<Delivery> order;

  const AllOrdersState({required this.order});
}

class AllOrdersErrorState extends MainListState {
  final String error;

  const AllOrdersErrorState({required this.error});
}

class AllOrdersLoadingState extends MainListState {}
