import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model.dart';
import '../../core/constants/app_strings.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final UserRepository _userRepository = UserRepository();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  var isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading.value = true;
    final cred = await _authService.login(emailController.text.trim(), passwordController.text.trim());
    isLoading.value = false;

    if (cred != null) {
      final user = await _userRepository.getUser(cred.user!.uid);
      if (user != null) {
        _routeBasedOnRole(user.role);
      }
    }
  }

  Future<void> signUp() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isLoading.value = true;
    final cred = await _authService.signUp(emailController.text.trim(), passwordController.text.trim());

    if (cred != null) {
      final newUser = UserModel(
        id: cred.user!.uid,
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        role: AppStrings.client,
      );
      await _userRepository.createUser(newUser);
      isLoading.value = false;
      Get.offAllNamed('/client-dashboard');
    } else {
      isLoading.value = false;
    }
  }

  void _routeBasedOnRole(String role) {
    if (role == AppStrings.admin) {
      Get.offAllNamed('/admin-dashboard');
    } else {
      Get.offAllNamed('/client-dashboard');
    }
  }

  void logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }
}
