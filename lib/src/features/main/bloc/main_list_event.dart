part of 'main_list_bloc.dart';

abstract class MainListEvent extends Equatable {
  const MainListEvent();

  @override
  List<Object> get props => [];
}

class GetAllDeliveries extends MainListEvent {}
