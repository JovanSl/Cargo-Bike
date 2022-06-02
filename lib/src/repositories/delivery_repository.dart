import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/delivery.dart';
import '../models/recipient.dart';
import '../models/sender.dart';

class DeliveryRepository {
  final _deliveries = FirebaseFirestore.instance.collection('deliveries');
  final _user = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addDelivery(Sender sender, Recipient recipient) {
    final Delivery _delivery = Delivery(
        userId: _user, sender: sender, recipient: recipient, status: 'active');
    return _deliveries.add(_delivery.toJson());
  }

  Future<List<Delivery>> getDeliveries() async {
    var result = await _deliveries.get();
    try {
      return result.docs.map((e) => Delivery.fromSnapshot(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
