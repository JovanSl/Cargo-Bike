part of 'incident_bloc.dart';

abstract class IncidentEvent extends Equatable {
  const IncidentEvent();

  @override
  List<Object> get props => [];
}

class CreateIncidentEvent extends IncidentEvent {
  final Incident incident;

  const CreateIncidentEvent(this.incident);
}

class GetAllIncidentsEvent extends IncidentEvent {}
