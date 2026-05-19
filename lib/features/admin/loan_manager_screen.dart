import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';
import '../../data/repositories/loan_repository.dart';

class LoanManagerScreen extends StatelessWidget {
  const LoanManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    final loanRepo = LoanRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Loan Applications')),
      body: Obx(() {
        if (controller.loans.isEmpty) return const Center(child: Text('No loans found.'));
        return ListView.builder(
          itemCount: controller.loans.length,
          itemBuilder: (context, index) {
            final loan = controller.loans[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('${loan.userName} - ${loan.type}'),
                subtitle: Text('\$${loan.amount} - ${loan.status}'),
                trailing: loan.status == 'pending' ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => loanRepo.updateLoanStatus(loan.id, 'approved'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => loanRepo.updateLoanStatus(loan.id, 'rejected'),
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
