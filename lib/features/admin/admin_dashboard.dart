import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/layouts/responsive_layout.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () => Get.toNamed('/admin-profile')),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _AdminDashboardContent(controller: controller, crossAxisCount: 2),
        web: _AdminDashboardContent(controller: controller, crossAxisCount: 4),
      ),
    );
  }
}

class _AdminDashboardContent extends StatelessWidget {
  final AdminController controller;
  final int crossAxisCount;

  const _AdminDashboardContent({required this.controller, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _StatCard(
                title: 'Total Clients',
                value: Obx(() => Text('${controller.clients.length}')),
                icon: Icons.people,
                color: Colors.blue,
              ),
              _StatCard(
                title: 'Pending Apps',
                value: Obx(() => Text('${controller.pendingApplicationsCount}')),
                icon: Icons.pending_actions,
                color: Colors.orange,
              ),
              _StatCard(
                title: 'Active Policies',
                value: Obx(() => Text('${controller.activePoliciesCount}')),
                icon: Icons.verified_user,
                color: Colors.green,
              ),
              _StatCard(
                title: 'Total Loans',
                value: Obx(() => Text('${controller.loans.length}')),
                icon: Icons.monetization_on,
                color: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: crossAxisCount > 2 ? 2 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 4,
            children: [
              _AdminMenuItem(
                title: 'Manage Clients',
                icon: Icons.person_search,
                onTap: () => Get.toNamed('/admin-clients'),
              ),
              _AdminMenuItem(
                title: 'Loan Applications',
                icon: Icons.assignment,
                onTap: () => Get.toNamed('/admin-loans'),
              ),
              _AdminMenuItem(
                title: 'Policy Management',
                icon: Icons.policy,
                onTap: () => Get.toNamed('/admin-policies'),
              ),
              _AdminMenuItem(
                title: 'Send Notifications',
                icon: Icons.send,
                onTap: () => Get.toNamed('/admin-notifications'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final Widget value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withAlpha(25), blurRadius: 10, spreadRadius: 5)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            child: value,
          ),
        ],
      ),
    );
  }
}

class _AdminMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _AdminMenuItem({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
