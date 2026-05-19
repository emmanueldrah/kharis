import 'package:cloud_firestore/cloud_firestore.dart';

class LoanModel {
  final String id;
  final String userId;
  final String userName;
  final String type;
  final double amount;
  final String purpose;
  final String status; // pending, approved, rejected
  final DateTime createdAt;

  LoanModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.type,
    required this.amount,
    required this.purpose,
    required this.status,
    required this.createdAt,
  });

  factory LoanModel.fromMap(Map<String, dynamic> map, String id) {
    return LoanModel(
      id: id,
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      type: map['type'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      purpose: map['purpose'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'type': type,
      'amount': amount,
      'purpose': purpose,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
