import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  String? _infoMessage;

  // FirebaseAuthException code -> ойлгомжтой мессеж
  String _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Ийм имэйлтэй хэрэглэгч олдсонгүй.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Имэйл эсвэл нууц үг буруу байна.';
      case 'email-already-in-use':
        return 'Энэ имэйл аль хэдийн бүртгэлтэй байна.';
      case 'weak-password':
        return 'Нууц үг хэт сул байна (хамгийн багадаа 6 тэмдэгт).';
      case 'invalid-email':
        return 'Имэйл хаягийн формат буруу байна.';
      case 'network-request-failed':
        return 'Интернэт холболтоо шалгана уу.';
      default:
        return e.message ?? 'Тодорхойгүй алдаа гарлаа.';
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _errorMessage = null;
      _infoMessage = null;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _mapError(e));
    }
  }

  Future<void> _register() async {
    setState(() {
      _errorMessage = null;
      _infoMessage = null;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _mapError(e));
    }
  }

  // Нэмэлт: нууц үг сэргээх
  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _infoMessage = null;
        _errorMessage = 'Эхлээд имэйл хаягаа оруулна уу.';
      });
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _errorMessage = null;
        _infoMessage = 'Нууц үг сэргээх линк имэйл рүү илгээгдлээ.';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _infoMessage = null;
        _errorMessage = _mapError(e);
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лаб №10 - Нэвтрэх')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'И-мэйл',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Нууц үг',
                border: OutlineInputBorder(),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            if (_infoMessage != null) ...[
              const SizedBox(height: 12),
              Text(_infoMessage!, style: const TextStyle(color: Colors.green)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _signIn, child: const Text('Нэвтрэх')),
            TextButton(
              onPressed: _register,
              child: const Text('Шинэ бүртгэл үүсгэх'),
            ),
            TextButton(
              onPressed: _resetPassword,
              child: const Text('Нууц үгээ мартсан уу?'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нүүр хуудас'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Гарах',
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Center(child: Text('Тавтай морил, ${user?.email}!')),
    );
  }
}
