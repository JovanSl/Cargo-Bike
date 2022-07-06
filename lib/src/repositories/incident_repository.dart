import 'package:cargo_bike/src/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/incident.dart';

class IncidentRepository {
  final _incidents = FirebaseFirestore.instance.collection('incidents');
  Future<void> addIncident(Incident incident) {
    return _incidents.doc().set(Incident(
            location: Location(
                lng: incident.location.lng, lat: incident.location.lat),
            message: incident.message.toString())
        .toJson());
  }

  Future<List<Incident>> getAllIncidents() async {
    List<Incident> allIncidents = [];
    var result = await _incidents.get();
    try {
      allIncidents = result.docs.map((e) => Incident.fromSnapshot(e)).toList();
      return allIncidents;
    } catch (e) {
      rethrow;
    }
  }
}
