import 'package:cargo_bike/src/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Incident {
  final String message;
  final Location location;

  Incident({required this.message, required this.location});

  factory Incident.fromMap(Map<String, dynamic> json) => Incident(
      message: json['message'], location: Location.fromMap(json['location']));

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'location': location.toJson(),
    };
  }

  factory Incident.fromSnapshot(DocumentSnapshot snapshot) {
    return Incident(
        message: snapshot['message'],
        location: Location.fromMap(snapshot['location']));
  }
}
