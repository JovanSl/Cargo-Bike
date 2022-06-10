import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        lat: json['lat'],
        lng: json['lng'],
      );

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromSnapshot(DocumentSnapshot snapshot) {
    return Location(lat: snapshot['lat'], lng: snapshot['lng']);
  }
}
