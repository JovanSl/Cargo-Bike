import 'package:cloud_firestore/cloud_firestore.dart';

import 'courier.dart';
import 'recipient.dart';
import 'sender.dart';

class Delivery {
  final String userId;
  final Sender sender;
  final Recipient recipient;
  final Courier? courier;

  Delivery(
      {this.courier,
      required this.userId,
      required this.sender,
      required this.recipient});

  factory Delivery.fromMap(Map<String, dynamic> json) => Delivery(
        userId: json['userId'],
        sender: Sender.fromMap(json["sender"]),
        recipient: Recipient.fromMap(json["recipient"]),
        courier: Courier.fromMap(json["courier"]),
      );

  factory Delivery.fromSnapshot(DocumentSnapshot snapshot) {
    return Delivery(
      userId: snapshot['userId'],
      sender: Sender.fromMap(snapshot["sender"]),
      recipient: Recipient.fromMap(snapshot["recipient"]),
      courier: Courier.fromMap(snapshot["courier"]),
    );
  }
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      userId: json['userId'],
      sender: json['sender'],
      recipient: json['recipient'],
      courier: json['courier'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'courier': courier?.toJson(),
    };
  }
}
