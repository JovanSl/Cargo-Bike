import 'package:cloud_firestore/cloud_firestore.dart';

import 'location.dart';

class Recipient {
  final String name;
  final String address;
  final String phone;
  final String additionalInfo;
  final Location? location;

  Recipient(
      {required this.name,
      required this.address,
      required this.phone,
      required this.additionalInfo,
      this.location});

  factory Recipient.fromMap(Map<String, dynamic> json) => Recipient(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      additionalInfo: json['additionalInfo'],
      location: Location.fromMap(json['location']));

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'additionalInfo': additionalInfo,
      'location': location?.toJson(),
    };
  }

  factory Recipient.fromSnapshot(DocumentSnapshot snapshot) {
    return Recipient(
        name: snapshot['name'],
        address: snapshot['address'],
        phone: snapshot['phone'],
        additionalInfo: snapshot['additionalInfo'],
        location: Location.fromMap(snapshot['location']));
  }
}
