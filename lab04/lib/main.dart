import 'package:flutter/material.dart';

void main() {
  runApp(const RegistrationFormApp());
}

class RegistrationFormApp extends StatelessWidget {
  const RegistrationFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _agreedToTerms = false;
  bool _receiveNotifications = true;
  bool _obscurePassword = true;
  bool _termsError = false;
  double _age = 20;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final formValid = _formKey.currentState!.validate();

    setState(() => _termsError = !_agreedToTerms);

    if (!formValid) {
      _showMessage('Мэдээллээ зөв бөглөнө үү', isError: true);
      return;
    }
    if (!_agreedToTerms) {
      _showMessage('Үйлчилгээний нөхцөлийг зөвшөөрнө үү', isError: true);
      return;
    }

    _showMessage('Амжилттай бүртгэгдлээ!');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Бүртгэл амжилттай'),
        content: Text(
          'Нэр: ${_nameController.text}\n'
              'И-мэйл: ${_emailController.text}\n'
              'Нас: ${_age.round()}\n'
              'Мэдэгдэл: ${_receiveNotifications ? "Асаалттай" : "Унтраалттай"}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showMessage(String text, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: isError ? Colors.red : Colors.green,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лаб №4 - Бүртгүүлэх'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Нэр',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Нэрээ оруулна уу';
                  }
                  if (v.trim().length < 2) {
                    return 'Нэр хэт богино байна';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,

                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'И-мэйл',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'И-мэйл оруулна уу';
                  }
                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(v.trim())) {
                    return 'И-мэйл формат буруу';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Нууц үг',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Нууц үг оруулна уу';
                  }
                  if (v.length < 6) {
                    return 'Дор хаяж 6 тэмдэгт байх';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Нас: ${_age.round()}',
                  style: const TextStyle(fontSize: 16)),
              Slider(
                value: _age,
                min: 10,
                max: 90,
                divisions: 80,
                label: _age.round().toString(),
                onChanged: (v) => setState(() => _age = v),
              ),

              CheckboxListTile(
                title: const Text('Үйлчилгээний нөхцөлтэй танилцсан'),
                value: _agreedToTerms,
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (v) => setState(() {
                  _agreedToTerms = v ?? false;
                  if (_agreedToTerms) _termsError = false;
                }),
              ),
              if (_termsError)
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(
                    'Үйлчилгээний нөхцөлийг зөвшөөрнө үү',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              SwitchListTile(
                title: const Text('Мэдэгдэл хүлээн авах'),
                value: _receiveNotifications,
                onChanged: (v) => setState(() => _receiveNotifications = v),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  alignment: Alignment.centerRight,
                ),
                onPressed: _submit,
                child: const Text('Бүртгүүлэх'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}