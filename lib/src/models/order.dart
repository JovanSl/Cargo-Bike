import 'recipient.dart';
import 'sender.dart';

class Order {
  final String userId;
  final Sender sender;
  final Recipient recipient;

  Order({required this.userId, required this.sender, required this.recipient});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
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
