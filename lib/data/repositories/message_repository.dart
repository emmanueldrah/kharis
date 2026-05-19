import '../models/message_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class MessageRepository {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  Stream<List<MessageModel>> getChatMessages(String userId) {
    return _firestoreService.streamCollection('messages', query: (q) =>
      q.where('chatId', isEqualTo: userId).orderBy('timestamp', descending: true)
    ).map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> sendMessage(MessageModel message, String userId) async {
    final data = message.toMap();
    data['chatId'] = userId;
    await _firestoreService.addDocument('messages', data);
  }
}
