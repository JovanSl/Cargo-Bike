import 'package:cloud_firestore/cloud_firestore.dart';

import 'recipient.dart';
import 'sender.dart';

class Delivery {
  final String userId;
  final Sender sender;
  final Recipient recipient;

  Delivery(
      {required this.userId, required this.sender, required this.recipient});

  factory Delivery.fromMap(Map<String, dynamic> json) => Delivery(
        userId: json['userId'],
        sender: Sender.fromMap(json["sender"]),
        recipient: Recipient.fromMap(json["recipient"]),
      );

  factory Delivery.fromSnapshot(DocumentSnapshot snapshot) {
    return Delivery(
      userId: snapshot['userId'],
      sender: Sender.fromMap(snapshot["sender"]),
      recipient: Recipient.fromMap(snapshot["recipient"]),
    );
  }
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      userId: json['userId'],
      sender: json['sender'],
      recipient: json['recipient'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
    };
  }
}
