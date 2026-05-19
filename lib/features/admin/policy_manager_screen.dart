import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';
import '../../data/repositories/policy_repository.dart';

class PolicyManagerScreen extends StatelessWidget {
  const PolicyManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    final policyRepo = PolicyRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Policy Management')),
      body: Obx(() {
        if (controller.policies.isEmpty) return const Center(child: Text('No policies found.'));
        return ListView.builder(
          itemCount: controller.policies.length,
          itemBuilder: (context, index) {
            final policy = controller.policies[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('${policy.userName} - ${policy.type}'),
                subtitle: Text('Status: ${policy.status}'),
                trailing: policy.status == 'pending' ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => policyRepo.updatePolicyStatus(policy.id, 'active'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => policyRepo.updatePolicyStatus(policy.id, 'expired'),
                    ),
                  ],
                ) : null,
              ),
            );
          },
        );
      }),
    );
  }
}
