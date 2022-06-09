import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<LoadMapEvent>(_loadMap);
    on<InitialMapEvent>(_initialize);
  }

  FutureOr<void> _loadMap(
      LoadMapEvent event, Emitter<DetailsState> emit) async {
    emit(LoadMapLoadingState());
    List<Location> locations = [];
    try {
      locations =
          await getLocations(event.senderAddress, event.recipiantAddress);
      emit(LoadRouteStateMap(locations));
    } catch (e) {
      emit(LoadRouteStateWithOutMap());
    }
  }

  Future getLocations(location1, location2) async {
    List<Location> x = [];
    x.addAll(await locationFromAddress(location1));
    x.addAll(await locationFromAddress(location2));
    return x;
  }

  FutureOr<void> _initialize(
      InitialMapEvent event, Emitter<DetailsState> emit) {
    emit(LoadMapLoadingState());
  }
}
