import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';
import '../../data/services/auth_service.dart';
import '../../shared/widgets/custom_button.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final authController = Get.find<AuthController>();
    final user = authService.user.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.admin_panel_settings, size: 50)),
            const SizedBox(height: 24),
            Text(user?.email ?? 'Admin', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('Administrator', style: TextStyle(color: Colors.grey)),
            const Spacer(),
            CustomButton(
              text: 'Logout',
              color: Colors.red,
              onPressed: authController.logout,
            ),
          ],
        ),
      ),
    );
  }
}
