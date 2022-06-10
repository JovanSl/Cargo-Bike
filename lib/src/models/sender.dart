import 'package:cloud_firestore/cloud_firestore.dart';

import 'location.dart';

class Sender {
  final String name;
  final String email;
  final String phone;
  final String address;
  final Location? location;

  factory Sender.fromMap(Map<String, dynamic> json) => Sender(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      location: Location.fromMap(json['location']));

  Sender(
      {required this.name,
      required this.email,
      required this.phone,
      required this.address,
      this.location});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'location': location?.toJson(),
    };
  }

  factory Sender.fromSnapshot(DocumentSnapshot snapshot) {
    return Sender(
      name: snapshot['name'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      address: snapshot['address'],
      location: Location.fromMap(snapshot['location']),
    );
  }
}
