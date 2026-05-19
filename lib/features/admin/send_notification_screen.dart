import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String? _selectedClientId;
  bool _isLoading = false;

  void _send() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    setState(() => _isLoading = true);
    // Logic to send notification via Cloud Messaging would go here
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    Get.back();
    Get.snackbar('Success', 'Notification sent');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Send Notification')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String?>(
              value: _selectedClientId,
              decoration: const InputDecoration(labelText: 'Recipient'),
              items: [
                const DropdownMenuItem(value: null, child: Text('All Clients')),
                ...controller.clients.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))),
              ],
              onChanged: (val) => setState(() => _selectedClientId = val),
            ),
            const SizedBox(height: 16),
            CustomTextField(label: 'Title', controller: _titleController),
            const SizedBox(height: 16),
            CustomTextField(label: 'Message', controller: _bodyController),
            const SizedBox(height: 32),
            CustomButton(text: 'Send Notification', isLoading: _isLoading, onPressed: _send),
          ],
        ),
      ),
    );
  }
}
