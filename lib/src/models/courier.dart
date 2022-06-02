import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Courier {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;

  Courier(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email});

  factory Courier.fromMap(Map<String, dynamic> json) => Courier(
      firstName: json['name'],
      lastName: json['lastName'],
      phone: json['phone'],
      email: json['email']);

  Map<String, dynamic> toJson() {
    return {
      'name': firstName,
      'email': email,
      'phone': phone,
      'lastName': lastName
    };
  }

  factory Courier.fromSnapshot(DocumentSnapshot snapshot) {
    return Courier(
        firstName: snapshot['firstName'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        lastName: snapshot['lastName']);
  }
}
