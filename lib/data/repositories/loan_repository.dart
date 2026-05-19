import '../models/loan_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class LoanRepository {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Future<void> applyForLoan(LoanModel loan) async {
    await _firestoreService.addDocument('loans', loan.toMap());
  }

  Stream<List<LoanModel>> getUserLoans(String uid) {
    return _firestoreService.streamCollection('loans', query: (q) => q.where('userId', isEqualTo: uid).orderBy('createdAt', descending: true)).map((snapshot) {
      return snapshot.docs.map((doc) => LoanModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Stream<List<LoanModel>> getAllLoans() {
    return _firestoreService.streamCollection('loans', query: (q) => q.orderBy('createdAt', descending: true)).map((snapshot) {
      return snapshot.docs.map((doc) => LoanModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> updateLoanStatus(String loanId, String status) async {
    await _firestoreService.updateDocument('loans/$loanId', {'status': status});
  }
}
