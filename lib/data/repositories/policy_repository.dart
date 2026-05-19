import '../models/policy_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class PolicyRepository {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Future<void> requestPolicy(PolicyModel policy) async {
    await _firestoreService.addDocument('policies', policy.toMap());
  }

  Stream<List<PolicyModel>> getUserPolicies(String uid) {
    return _firestoreService.streamCollection('policies', query: (q) => q.where('userId', isEqualTo: uid).orderBy('createdAt', descending: true)).map((snapshot) {
      return snapshot.docs.map((doc) => PolicyModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Stream<List<PolicyModel>> getAllPolicies() {
    return _firestoreService.streamCollection('policies', query: (q) => q.orderBy('createdAt', descending: true)).map((snapshot) {
      return snapshot.docs.map((doc) => PolicyModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> updatePolicyStatus(String policyId, String status) async {
    await _firestoreService.updateDocument('policies/$policyId', {'status': status});
  }
}
