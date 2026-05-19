import '../models/notification_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class NotificationRepository {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Stream<List<NotificationModel>> getNotifications(String? userId) {
    return _firestoreService.streamCollection('notifications', query: (q) {
      if (userId == null) {
        return q.orderBy('createdAt', descending: true);
      }
      return q.where('userId', whereIn: [userId, null]).orderBy('createdAt', descending: true);
    }).map((snapshot) {
      return snapshot.docs.map((doc) => NotificationModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> sendNotification(NotificationModel notification) async {
    await _firestoreService.addDocument('notifications', notification.toMap());
  }
}
