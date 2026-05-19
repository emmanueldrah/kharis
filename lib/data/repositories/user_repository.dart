import '../models/user_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class UserRepository {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Future<void> createUser(UserModel user) async {
    await _firestoreService.setData('users/${user.id}', user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestoreService.getData('users/$uid');
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Stream<UserModel?> streamUser(String uid) {
    return _firestoreService.streamData('users/$uid').map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    });
  }

  Stream<List<UserModel>> getAllClients() {
    return _firestoreService.streamCollection('users', query: (q) => q.where('role', isEqualTo: 'client')).map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }
}
