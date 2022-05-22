import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order.dart';
import '../models/recipient.dart';
import '../models/sender.dart';

class AddOrderRepository {
  final _orders = FirebaseFirestore.instance.collection('orders');
  final _user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addOrder(Sender sender, Recipient recipient) {
    final Order _order =
        Order(userId: _user, sender: sender, recipient: recipient);
    return _orders.add(_order.toJson());
  }
}
