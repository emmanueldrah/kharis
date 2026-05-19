import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'client_controller.dart';

class LoanStatusScreen extends StatelessWidget {
  const LoanStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClientController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Loan Applications')),
      body: Obx(() {
        if (controller.loans.isEmpty) {
          return const Center(child: Text('No loan applications found.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.loans.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final loan = controller.loans[index];
            return Card(
              child: ListTile(
                title: Text(loan.type, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount: \$${loan.amount}'),
                    Text('Date: ${loan.createdAt.toString().split(' ')[0]}'),
                  ],
                ),
                trailing: _StatusBadge(status: loan.status),
              ),
            );
          },
        );
      }),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(12)),
      child: Text(status.toUpperCase(), style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
