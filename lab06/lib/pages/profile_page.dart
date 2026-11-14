import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 56, child: Icon(Icons.person, size: 64)),
          SizedBox(height: 16),
          Text(
            'Гэрэл',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('b241940001', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
