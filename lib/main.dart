import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'data/services/auth_service.dart';
import 'data/services/firestore_service.dart';
import 'data/services/storage_service.dart';
import 'features/auth/splash_screen.dart';
import 'features/auth/onboarding_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/client/client_dashboard.dart';
import 'features/client/loan_application_screen.dart';
import 'features/client/loan_status_screen.dart';
import 'features/client/policies_screen.dart';
import 'features/client/policy_inquiry_screen.dart';
import 'features/client/messaging_screen.dart';
import 'features/client/profile_screen.dart';
import 'features/notifications/notifications_screen.dart';
import 'features/admin/admin_dashboard.dart';
import 'features/admin/client_list_screen.dart';
import 'features/admin/client_detail_screen.dart';
import 'features/admin/loan_manager_screen.dart';
import 'features/admin/policy_manager_screen.dart';
import 'features/admin/send_notification_screen.dart';
import 'features/admin/admin_profile_screen.dart';
import 'features/auth/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Services
  Get.put(FirestoreService());
  Get.put(StorageService());
  Get.put(AuthService());
  Get.put(AuthController());

  runApp(const KharisApp());
}

class KharisApp extends StatelessWidget {
  const KharisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kharis Investment Services',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),

        // Client Routes
        GetPage(name: '/client-dashboard', page: () => const ClientDashboard()),
        GetPage(name: '/loan-application', page: () => const LoanApplicationScreen()),
        GetPage(name: '/loan-status', page: () => const LoanStatusScreen()),
        GetPage(name: '/policies', page: () => const PoliciesScreen()),
        GetPage(name: '/policy-inquiry', page: () => const PolicyInquiryScreen()),
        GetPage(name: '/messaging', page: () => const MessagingScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/notifications', page: () => const NotificationsScreen()),

        // Admin Routes
        GetPage(name: '/admin-dashboard', page: () => const AdminDashboard()),
        GetPage(name: '/admin-clients', page: () => const ClientListScreen()),
        GetPage(name: '/admin-client-detail', page: () => const ClientDetailScreen()),
        GetPage(name: '/admin-loans', page: () => const LoanManagerScreen()),
        GetPage(name: '/admin-policies', page: () => const PolicyManagerScreen()),
        GetPage(name: '/admin-notifications', page: () => const SendNotificationScreen()),
        GetPage(name: '/admin-profile', page: () => const AdminProfileScreen()),
      ],
    );
  }
}
