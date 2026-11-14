import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentDetailPage extends StatefulWidget {
  const StudentDetailPage({super.key});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  bool? _liked;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final student = args['student'] as Student;
    _liked ??= args['liked'] as bool;
    final liked = _liked!;

    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 48,
                child: Icon(Icons.person, size: 56),
              ),
            ),
            const SizedBox(height: 20),
            Text('ID: ${student.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Мэргэжил: ${student.major}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Курс: ${student.course}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => setState(() => _liked = !liked),
              icon: Icon(
                liked ? Icons.star : Icons.star_border,
                color: Colors.blue,
              ),
              label: Text(liked ? 'Таалагдсан' : 'Таалагдсанд нэмэх'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => Navigator.pop(context, liked),
              child: const Text('Буцах'),
            ),
          ],
        ),
      ),
    );
  }
}
