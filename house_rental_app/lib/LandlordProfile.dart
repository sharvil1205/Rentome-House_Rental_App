import 'package:flutter/material.dart';

class LandlordProfile extends StatefulWidget {
  const LandlordProfile({super.key});

  @override
  State<LandlordProfile> createState() => _LandlordProfileState();
}

class _LandlordProfileState extends State<LandlordProfile> {

  void _handleEditPressed(){

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
      body: Center(child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 24.0),
            CircleAvatar(
              backgroundImage: NetworkImage('images/ryuk.webp'),
              radius: 48.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            
          ],
        ),
      ),
      )
    );
  }
}

