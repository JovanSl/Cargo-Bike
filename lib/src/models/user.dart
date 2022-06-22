import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? address;
  String? phone;
  String? imageUrl;
  String? userId;
  bool? isCourrier;

  UserModel(
      {this.firstName,
      this.lastName,
      this.address,
      this.phone,
      this.imageUrl,
      this.userId,
      this.isCourrier});

  List<Object?> get props =>
      [firstName, lastName, address, phone, imageUrl, userId, isCourrier];

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        firstName: snapshot['firstName'],
        lastName: snapshot['lastName'],
        address: snapshot['address'],
        phone: snapshot['phone'],
        imageUrl: snapshot['imageUrl'],
        userId: snapshot['userId'],
        isCourrier: snapshot['isCourrier']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName ?? '',
      'lastName': lastName ?? '',
      'address': address ?? '',
      'phone': phone ?? '',
      'imageUrl': imageUrl ?? '',
      'userId': userId ?? '',
      'isCourrier': isCourrier,
    };
  }
}
