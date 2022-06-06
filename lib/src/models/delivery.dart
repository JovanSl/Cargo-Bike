import 'package:cloud_firestore/cloud_firestore.dart';

import 'courier.dart';
import 'recipient.dart';
import 'sender.dart';

class Delivery {
  final String userId;
  final Sender sender;
  final Recipient recipient;
  final Courier? courier;
  final String status;
  final String id;

  Delivery(
      {required this.userId,
      required this.sender,
      required this.recipient,
      this.courier,
      required this.status,
      required this.id});

  factory Delivery.fromMap(Map<String, dynamic> json) => Delivery(
        userId: json['userId'],
        sender: Sender.fromMap(json["sender"]),
        recipient: Recipient.fromMap(json["recipient"]),
        courier: Courier?.fromMap(json["courier"]),
        status: json['status'],
        id: json['id'],
      );

  factory Delivery.fromSnapshot(DocumentSnapshot snapshot) {
    return Delivery(
      userId: snapshot['userId'],
      sender: Sender.fromMap(snapshot["sender"]),
      recipient: Recipient.fromMap(snapshot["recipient"]),
      courier: snapshot["courier"] != null
          ? Courier?.fromMap(snapshot["courier"])
          : Courier(firstName: '', lastName: '', phone: '', email: ''),
      status: snapshot['status'],
      id: snapshot['id'],
    );
  }
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      userId: json['userId'],
      sender: json['sender'],
      recipient: json['recipient'],
      courier: json['courier']!,
      status: json['status'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'courier': courier?.toJson(),
      'status': status,
      'id': id,
    };
  }
}
