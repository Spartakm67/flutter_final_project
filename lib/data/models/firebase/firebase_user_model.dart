import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String? phoneNumber;
  final Timestamp createdAt;
  final Map<String, dynamic>? otherDetails;

  UserModel({
    required this.userId,
    required this.email,
    this.phoneNumber,
    required this.createdAt,
    this.otherDetails,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userId: data['userId'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      createdAt: data['createdAt'],
      otherDetails: data['otherDetails'] ?? {},
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      'createdAt': createdAt,
      if (otherDetails != null) 'otherDetails': otherDetails,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (otherDetails != null) 'otherDetails': otherDetails,
    };
  }
}
