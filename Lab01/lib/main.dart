import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const HelloFlutterApp());
}

class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hii Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HelloFlutterPage(),
    );
  }
}

class HelloFlutterPage extends StatelessWidget {
  const HelloFlutterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double angle = 45 * math.pi / 180;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Лаб №1 - Hi Flutter',
          style: TextStyle(color: Colors.blueAccent),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: angle,
              child: const Icon(
                Icons.cruelty_free, size: 80, color: Colors.pink,),
            ),
            const SizedBox(height: 20),
            Transform.rotate(
                angle: angle,
                child: const Text(
                'Миний анхны Flutter project',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Transform.rotate(
              angle: angle,
              child: const Text(
                'А. Гэрэл B241940001',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}