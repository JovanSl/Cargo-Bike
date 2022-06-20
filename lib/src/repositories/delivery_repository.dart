import 'dart:convert';

import 'package:cargo_bike/src/models/suggested_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../constants/address_api.dart';
import '../exceptions/api_exception.dart';
import '../models/delivery.dart';
import '../models/recipient.dart';
import '../models/sender.dart';

class DeliveryRepository {
  final _deliveries = FirebaseFirestore.instance.collection('deliveries');

  Future<void> addDelivery(Sender sender, Recipient recipient) {
    final _user = FirebaseAuth.instance.currentUser!.uid;
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
    final _user = FirebaseAuth.instance.currentUser!.uid;
    List<Delivery> allDeliveries = [];
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
    final _user = FirebaseAuth.instance.currentUser!.uid;
    List<Delivery> allDeliveries = [];
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

  Future suggestionProcess(String address) async {
    List<Suggested> suggestedLocations = [];
    final response = await http.get(
      Uri.parse(AddressApi.searchEndpoint + address + "&limit=3"),
    );
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body)['features'] as List;
      suggestedLocations =
          extractedData.map((e) => Suggested.fromJson(e)).toList();
      return suggestedLocations;
    } else {
      throw ApiException("Api Error");
    }
  }

  Future<void> removeDelivery(String id) {
    return _deliveries.doc(id).delete();
  }
}
