import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final isCredit = index % 3 == 0;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isCredit ? Colors.green.withAlpha(20) : Colors.red.withAlpha(20),
              child: Icon(
                isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                color: isCredit ? Colors.green : Colors.red,
              ),
            ),
            title: Text(isCredit ? 'Loan Disbursement' : 'Loan Repayment'),
            subtitle: Text('12 Oct 2023'),
            trailing: Text(
              '${isCredit ? "+" : "-"}\$${(index + 1) * 100}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isCredit ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
