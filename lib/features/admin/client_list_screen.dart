import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_controller.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final _searchController = TextEditingController();
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search clients...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) => setState(() => _filter = val.toLowerCase()),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filteredClients = controller.clients.where((c) =>
                  c.name.toLowerCase().contains(_filter) ||
                  c.email.toLowerCase().contains(_filter)).toList();

              if (filteredClients.isEmpty) {
                return const Center(child: Text('No clients found.'));
              }

              return ListView.builder(
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final client = filteredClients[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(client.name),
                    subtitle: Text(client.email),
                    onTap: () => Get.toNamed('/admin-client-detail', arguments: client),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
