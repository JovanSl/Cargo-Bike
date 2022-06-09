import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/delivery.dart';
import '../models/recipient.dart';
import '../models/sender.dart';

class DeliveryRepository {
  final _deliveries = FirebaseFirestore.instance.collection('deliveries');
  final _user = FirebaseAuth.instance.currentUser!.uid;
  List<Delivery> allDeliveries = [];

  Future<void> addDelivery(Sender sender, Recipient recipient) {
    DocumentReference documentReference = _deliveries.doc();
    return documentReference.set(Delivery(
            userId: _user,
            sender: sender,
            recipient: recipient,
            status: 'active',
            id: documentReference.id)
        .toJson());
  }

  Future<List<Delivery>> getActiveDeliveries() async {
    var result = await _deliveries.get();
    try {
      allDeliveries = result.docs
          .map((e) => Delivery.fromSnapshot(e))
          .where((element) =>
              element.status == 'active' && element.userId == _user)
          .toList();
      return allDeliveries;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Delivery>> getHistory() async {
    var result = await _deliveries.get();
    try {
      allDeliveries = result.docs
          .map((e) => Delivery.fromSnapshot(e))
          .where(
              (element) => element.status == 'done' && element.userId == _user)
          .toList();
      return allDeliveries;
    } catch (e) {
      rethrow;
    }
  }
}
