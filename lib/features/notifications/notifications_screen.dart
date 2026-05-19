import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/models/notification_model.dart';
import '../../data/services/auth_service.dart';
import '../../core/theme/app_colors.dart';

class NotificationController extends GetxController {
  final NotificationRepository _notificationRepository = NotificationRepository();
  final AuthService _authService = Get.find<AuthService>();

  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final uid = _authService.user.value?.uid;
    notifications.bindStream(_notificationRepository.getNotifications(uid));
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text('No notifications yet.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(
                '${notification.createdAt.hour}:${notification.createdAt.minute}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            );
          },
        );
      }),
    );
  }
}
