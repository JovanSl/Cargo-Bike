import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? firstName;
  String? lastName;
  String? address;
  String? imageUrl;

  UserModel({
    this.firstName,
    this.lastName,
    this.address,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        address,
        imageUrl,
      ];

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      address: snapshot['address'],
      imageUrl: snapshot['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'imageUrl': imageUrl,
    };
  }
}
