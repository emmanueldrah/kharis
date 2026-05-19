import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/loan_model.dart';
import '../../data/repositories/loan_repository.dart';
import '../../data/services/auth_service.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';
import '../../core/constants/app_strings.dart';

class LoanApplicationScreen extends StatefulWidget {
  const LoanApplicationScreen({super.key});

  @override
  State<LoanApplicationScreen> createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _purposeController = TextEditingController();
  String _selectedType = AppStrings.loanTypes[0];
  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final authService = Get.find<AuthService>();
      final loanRepo = LoanRepository();

      final loan = LoanModel(
        id: '',
        userId: authService.user.value!.uid,
        userName: authService.user.value!.displayName ?? 'Client',
        type: _selectedType,
        amount: double.parse(_amountController.text),
        purpose: _purposeController.text,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await loanRepo.applyForLoan(loan);
      setState(() => _isLoading = false);
      Get.back();
      Get.snackbar('Success', 'Loan application submitted successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loan Application')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Loan Type'),
                items: AppStrings.loanTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                onChanged: (val) => setState(() => _selectedType = val!),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Amount',
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Purpose',
                controller: _purposeController,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Submit Application',
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
