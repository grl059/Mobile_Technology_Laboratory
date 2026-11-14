import 'package:flutter/material.dart';

import '../models/student.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final Set<int> _liked = {};

  Future<void> _openDetail(Student student) async {
    final result = await Navigator.pushNamed(
      context,
      '/detail',
      arguments: {'student': student, 'liked': _liked.contains(student.id)},
    );

    if (result is bool && mounted) {
      setState(() {
        if (result) {
          _liked.add(student.id);
        } else {
          _liked.remove(student.id);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(student.name),
          subtitle: Text(student.major),
          trailing: _liked.contains(student.id)
              ? const Icon(Icons.star, color: Colors.blue)
              : const Icon(Icons.chevron_right),
          onTap: () => _openDetail(student),
        );
      },
    );
  }
}
