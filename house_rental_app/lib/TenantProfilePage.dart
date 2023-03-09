import 'package:flutter/material.dart';

class TenantProfilePage extends StatelessWidget {
  final String name;
  final String profilePictureUrl;
  final String email;
  final bool isEmployed;

  const TenantProfilePage({super.key, 
    required this.name,
    required this.profilePictureUrl,
    required this.email,
    required this.isEmployed,
  });

  void _handleEditPressed() {
    // Show form or dialog to edit profile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _handleEditPressed,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24.0),
            CircleAvatar(
              backgroundImage: NetworkImage(profilePictureUrl),
              radius: 48.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              name,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              email,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEmployed ? Icons.work : Icons.work_outline,
                  color: isEmployed ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8.0),
                Text(
                  isEmployed ? 'Employed' : 'Unemployed',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isEmployed ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}