import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import 'admin_controller.dart';

class ClientDetailScreen extends StatelessWidget {
  const ClientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel client = Get.arguments;
    final controller = Get.find<AdminController>();

    final clientLoans = controller.loans.where((l) => l.userId == client.id).toList();
    final clientPolicies = controller.policies.where((p) => p.userId == client.id).toList();

    return Scaffold(
      appBar: AppBar(title: Text(client.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Client Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Email: ${client.email}'),
            Text('Phone: ${client.phone ?? "N/A"}'),
            const Divider(height: 32),
            const Text('Loans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: clientLoans.length,
              itemBuilder: (context, index) {
                final loan = clientLoans[index];
                return ListTile(
                  title: Text(loan.type),
                  subtitle: Text('\$${loan.amount}'),
                  trailing: Text(loan.status),
                );
              },
            ),
            const Divider(height: 32),
            const Text('Policies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: clientPolicies.length,
              itemBuilder: (context, index) {
                final policy = clientPolicies[index];
                return ListTile(
                  title: Text(policy.type),
                  subtitle: Text(policy.status),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
