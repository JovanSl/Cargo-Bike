import 'package:cloud_firestore/cloud_firestore.dart';

class Recipient {
  final String name;
  final String address;
  final String phone;
  final String additionalInfo;

  Recipient(
      {required this.name,
      required this.address,
      required this.phone,
      required this.additionalInfo});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'additionalInfo': additionalInfo
    };
  }

  factory Recipient.fromSnapshot(DocumentSnapshot snapshot) {
    return Recipient(
        name: snapshot['name'],
        address: snapshot['address'],
        phone: snapshot['phone'],
        additionalInfo: snapshot['additionalInfo']);
  }
}
