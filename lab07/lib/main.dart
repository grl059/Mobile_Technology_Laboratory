import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const UniversityApp());

class UniversityApp extends StatelessWidget {
  const UniversityApp({super.key});

  ThemeData _buildTheme(Brightness brightness) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: brightness,
      ),
    );
    return base.copyWith(
      textTheme: GoogleFonts.montserratTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: base.colorScheme.primary,
        foregroundColor: base.colorScheme.onPrimary,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Info',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const UniversityHomePage(),
    );
  }
}

class UniversityHomePage extends StatelessWidget {
  const UniversityHomePage({super.key});

  static const _departments = [
    {'name': 'Мэдээлэл, холбооны технологи', 'icon': Icons.computer},
    {'name': 'Эдийн засаг, бизнес', 'icon': Icons.business},
    {'name': 'Барилга, архитектур', 'icon': Icons.apartment},
    {'name': 'Хэл, соёл судлал', 'icon': Icons.language},
    {'name': 'Анагаах ухаан', 'icon': Icons.local_hospital},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб №7 - Их сургуулийн апп')),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/campus.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const Icon(Icons.school, size: 64),
                ),
              ),
              Container(
                height: 180,
                color: Colors.black45,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Шинжлэх Ухаан Технологийн Их Сургууль',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _departments.length,
              itemBuilder: (context, index) {
                final dept = _departments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(
                      dept['icon'] as IconData,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(dept['name'] as String),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
