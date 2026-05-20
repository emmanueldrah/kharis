import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/layouts/responsive_layout.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClientController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kharis Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Get.toNamed('/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: ResponsiveLayout(
        mobile: _DashboardContent(controller: controller, crossAxisCount: 2),
        web: _DashboardContent(controller: controller, crossAxisCount: 4),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 1) Get.toNamed('/messaging');
          if (index == 2) Get.toNamed('/profile');
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final ClientController controller;
  final int crossAxisCount;

  const _DashboardContent({required this.controller, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.5,
            children: [
              _SummaryCard(
                title: 'Total Loans',
                value: Obx(() => Text('\$${controller.totalLoanAmount.toStringAsFixed(2)}')),
                icon: Icons.money,
                color: Colors.blue,
              ),
              _SummaryCard(
                title: 'Active Policies',
                value: Obx(() => Text('${controller.activePoliciesCount}')),
                icon: Icons.security,
                color: Colors.green,
                onTap: () => Get.toNamed('/policies'),
              ),
              _SummaryCard(
                title: 'History',
                value: const Text('Recent'),
                icon: Icons.history,
                color: Colors.orange,
                onTap: () => Get.toNamed('/transactions'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Loans',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/loan-status'),
                child: const Text('View All'),
              ),
            ],
          ),
          Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.loans.length > 3 ? 3 : controller.loans.length,
            itemBuilder: (context, index) {
              final loan = controller.loans[index];
              return ListTile(
                title: Text(loan.type),
                subtitle: Text('\$${loan.amount}'),
                trailing: _StatusBadge(status: loan.status),
              );
            },
          )),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: crossAxisCount > 2 ? 400 : double.infinity,
              child: Column(
                children: [
                  CustomButton(
                    text: 'Apply for New Loan',
                    onPressed: () => Get.toNamed('/loan-application'),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Explore Policies',
                    color: AppColors.darkNavy,
                    onPressed: () => Get.toNamed('/policies'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final Widget value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _SummaryCard({required this.title, required this.value, required this.icon, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.withAlpha(25), blurRadius: 10, spreadRadius: 5)],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  DefaultTextStyle(
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    child: value,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case 'approved': color = Colors.green; break;
      case 'rejected': color = Colors.red; break;
      default: color = Colors.orange;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(8)),
      child: Text(status.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
