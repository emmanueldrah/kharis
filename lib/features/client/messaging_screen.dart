import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../../data/repositories/message_repository.dart';
import '../../data/models/message_model.dart';
import '../../core/theme/app_colors.dart';

class MessagingController extends GetxController {
  final MessageRepository _messageRepository = MessageRepository();
  final AuthService _authService = Get.find<AuthService>();
  final messageController = TextEditingController();

  var messages = <MessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final uid = _authService.user.value?.uid;
    if (uid != null) {
      messages.bindStream(_messageRepository.getChatMessages(uid));
    }
  }

  void sendMessage() async {
    final uid = _authService.user.value?.uid;
    if (uid == null || messageController.text.trim().isEmpty) return;

    final newMessage = MessageModel(
      id: '',
      senderId: uid,
      receiverId: 'admin',
      content: messageController.text.trim(),
      timestamp: DateTime.now(),
      isRead: false,
    );

    messageController.clear();
    await _messageRepository.sendMessage(newMessage, uid);
  }
}

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessagingController());
    final currentUid = Get.find<AuthService>().user.value?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Support Chat')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final msg = controller.messages[index];
                bool isMe = msg.senderId == currentUid;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primary : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.content,
                      style: TextStyle(color: isMe ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
