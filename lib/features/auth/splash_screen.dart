import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../data/services/auth_service.dart';
import '../../data/repositories/user_repository.dart';
import '../../core/constants/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    final authService = Get.find<AuthService>();
    if (authService.user.value != null) {
      final userRepository = UserRepository();
      final user = await userRepository.getUser(authService.user.value!.uid);
      if (user != null) {
        if (user.role == AppStrings.admin) {
          Get.offAllNamed('/admin-dashboard');
        } else {
          Get.offAllNamed('/client-dashboard');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offAllNamed('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance, size: 100, color: AppColors.white),
            SizedBox(height: 24),
            Text(
              'KHARIS',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            Text(
              'INVESTMENT SERVICES',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
