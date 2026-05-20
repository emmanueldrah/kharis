import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/policy_model.dart';
import '../../core/theme/app_colors.dart';

class PolicyDetailScreen extends StatelessWidget {
  const PolicyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PolicyModel policy = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(policy.type)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailItem(label: 'Policy Type', value: policy.type),
            _DetailItem(label: 'Status', value: policy.status.toUpperCase(), color: _getStatusColor(policy.status)),
            _DetailItem(label: 'Date Issued', value: policy.createdAt.toString().split(' ')[0]),
            const SizedBox(height: 24),
            const Text('Policy Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(policy.details ?? 'No additional details provided.', style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            if (policy.type == 'Investment Policy')
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Growth'),
                        Text('8.5% p.a.', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Next Maturity'),
                        Text('12 Dec 2026', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active': return Colors.green;
      case 'expired': return Colors.red;
      default: return Colors.orange;
    }
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _DetailItem({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
