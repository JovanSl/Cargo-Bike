import 'package:cloud_firestore/cloud_firestore.dart';

class Sender {
  final String name;
  final String email;
  final String phone;
  final String address;

  Sender(
      {required this.name,
      required this.email,
      required this.phone,
      required this.address});

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'address': address};
  }

  factory Sender.fromSnapshot(DocumentSnapshot snapshot) {
    return Sender(
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        address: snapshot['address']);
  }
}
