part of 'incident_bloc.dart';

abstract class IncidentState extends Equatable {
  const IncidentState();

  @override
  List<Object> get props => [];
}

class IncidentInitial extends IncidentState {}

class AllIncidentsState extends IncidentState {
  final List<Incident> allIncidents;

  const AllIncidentsState(this.allIncidents);
}

class IncidentLoadingState extends IncidentState {}

class IncidentErrorState extends IncidentState {}

class IncidentSuccessState extends IncidentState {}
