import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? address;
  String? phone;
  String? imageUrl;
  String? userId;

  UserModel(
      {this.firstName,
      this.lastName,
      this.address,
      this.phone,
      this.imageUrl,
      this.userId});

  List<Object?> get props =>
      [firstName, lastName, address, phone, imageUrl, userId];

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      address: snapshot['address'],
      phone: snapshot['phone'],
      imageUrl: snapshot['imageUrl'],
      userId: snapshot['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phone': phone,
      'imageUrl': imageUrl,
      'userId': userId,
    };
  }
}
