import 'package:cloud_firestore/cloud_firestore.dart';

class PolicyModel {
  final String id;
  final String userId;
  final String userName;
  final String type;
  final String status; // active, pending, expired
  final DateTime createdAt;
  final String? details;

  PolicyModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.type,
    required this.status,
    required this.createdAt,
    this.details,
  });

  factory PolicyModel.fromMap(Map<String, dynamic> map, String id) {
    return PolicyModel(
      id: id,
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      type: map['type'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      details: map['details'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'type': type,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'details': details,
    };
  }
}
