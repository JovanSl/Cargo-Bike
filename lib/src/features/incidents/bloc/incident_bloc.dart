import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/incident.dart';
import '../../../repositories/incident_repository.dart';

part 'incident_event.dart';
part 'incident_state.dart';

class IncidentBloc extends Bloc<IncidentEvent, IncidentState> {
  final IncidentRepository repository;
  IncidentBloc({required this.repository}) : super(IncidentInitial()) {
    on<CreateIncidentEvent>(_createIncident);
    on<GetAllIncidentsEvent>(_getAllIncidents);
  }

  FutureOr<void> _createIncident(
      CreateIncidentEvent event, Emitter<IncidentState> emit) async {
    try {
      await repository.addIncident(
        event.incident,
      );
      add(GetAllIncidentsEvent());
    } catch (e) {
      emit(IncidentErrorState());
    }
  }

  FutureOr<void> _getAllIncidents(event, Emitter<IncidentState> emit) async {
    emit(IncidentLoadingState());
    List<Incident> allIncidents = [];
    try {
      var result = await repository.getAllIncidents();
      for (var result in result) {
        allIncidents
            .add(Incident(message: result.message, location: result.location));
      }
      emit(AllIncidentsState(allIncidents));
    } catch (e) {
      emit(IncidentErrorState());
    }
  }
}
