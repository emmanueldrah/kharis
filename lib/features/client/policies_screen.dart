import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_controller.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Insurance & Policies')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Active Policies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(() => controller.policies.isEmpty
                ? const Text('You have no active policies.')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.policies.length,
                    itemBuilder: (context, index) {
                      final policy = controller.policies[index];
                      return Card(
                        child: ListTile(
                          title: Text(policy.type),
                          subtitle: Text('Status: ${policy.status}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => Get.toNamed('/policy-detail', arguments: policy),
                        ),
                      );
                    },
                  )),
            const SizedBox(height: 32),
            const Text(
              'Explore New Policies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: AppStrings.policyTypes.length,
              itemBuilder: (context, index) {
                final type = AppStrings.policyTypes[index];
                return InkWell(
                  onTap: () => Get.toNamed('/policy-inquiry', arguments: type),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withAlpha(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.description_outlined, color: AppColors.primary),
                        const SizedBox(height: 8),
                        Text(
                          type,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
