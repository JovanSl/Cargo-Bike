part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class LoadMapLoadingState extends DetailsState {}

class LoadRouteStateMap extends DetailsState {
  final List<Location> location;

  const LoadRouteStateMap(this.location);

  @override
  List<Object> get props => [location];
}

class LoadRouteStateWithOutMap extends DetailsState {}
