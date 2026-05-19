import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/policy_model.dart';
import '../../data/repositories/policy_repository.dart';
import '../../data/services/auth_service.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class PolicyInquiryScreen extends StatefulWidget {
  const PolicyInquiryScreen({super.key});

  @override
  State<PolicyInquiryScreen> createState() => _PolicyInquiryScreenState();
}

class _PolicyInquiryScreenState extends State<PolicyInquiryScreen> {
  final _detailsController = TextEditingController();
  late String _policyType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _policyType = Get.arguments ?? 'General Policy';
  }

  void _submit() async {
    setState(() => _isLoading = true);
    final authService = Get.find<AuthService>();
    final policyRepo = PolicyRepository();

    final policy = PolicyModel(
      id: '',
      userId: authService.user.value!.uid,
      userName: authService.user.value!.displayName ?? 'Client',
      type: _policyType,
      status: 'pending',
      createdAt: DateTime.now(),
      details: _detailsController.text,
    );

    await policyRepo.requestPolicy(policy);
    setState(() => _isLoading = false);
    Get.back();
    Get.snackbar('Success', 'Policy inquiry sent successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inquiry: $_policyType')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tell us more about your requirements',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Details/Questions',
              controller: _detailsController,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Submit Inquiry',
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
