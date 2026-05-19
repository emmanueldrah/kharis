import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';
import '../../data/services/auth_service.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final authController = Get.find<AuthController>();
  final userRepository = UserRepository();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final authService = Get.find<AuthService>();
    final uid = authService.user.value?.uid;
    if (uid != null) {
      final user = await userRepository.getUser(uid);
      if (user != null) {
        _nameController.text = user.name;
        _phoneController.text = user.phone ?? '';
      }
    }
  }

  void _updateProfile() async {
    final authService = Get.find<AuthService>();
    final uid = authService.user.value?.uid;
    if (uid == null) return;

    setState(() => _isLoading = true);
    await userRepository.createUser(UserModel(
      id: uid,
      email: authService.user.value!.email!,
      name: _nameController.text.trim(),
      role: 'client',
      phone: _phoneController.text.trim(),
    ));
    setState(() => _isLoading = false);
    Get.snackbar('Success', 'Profile updated successfully');
  }

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final user = authService.user.value;

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 24),
            Text(user?.email ?? '', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 32),
            CustomTextField(label: 'Full Name', controller: _nameController),
            const SizedBox(height: 16),
            CustomTextField(label: 'Phone Number', controller: _phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 32),
            CustomButton(text: 'Update Profile', isLoading: _isLoading, onPressed: _updateProfile),
            const SizedBox(height: 16),
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
