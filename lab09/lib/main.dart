import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todoBox');
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final Box _box = Hive.box('todoBox');
  final TextEditingController _controller = TextEditingController();

  final List<String> _categories = ['Ажил', 'Сургалт', 'Хувийн'];
  String _selectedCategory = 'Ажил';
  String _filter = 'Бүгд'; 

  void _addTodo() {
    if (_controller.text.trim().isEmpty) return;
    _box.add({
      'title': _controller.text.trim(),
      'done': false,
      'category': _selectedCategory,
    });
    _controller.clear();
  }

  void _toggleDone(dynamic key, Map item) {
    _box.put(key, {
      'title': item['title'],
      'done': !item['done'],
      'category': item['category'],
    });
  }

  void _deleteTodo(dynamic key) {
    _box.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лаб №9 - To-Do App'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Шинэ даалгавар нэмэх...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  iconSize: 32,
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: ['Бүгд', ..._categories].map((c) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: _filter == c,
                    onSelected: (_) => setState(() => _filter = c),
                  ),
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _box.listenable(),
              builder: (context, Box box, _) {
                final keys = box.keys.where((k) {
                  final item = box.get(k) as Map;
                  final cat = item['category'] ?? 'Хувийн';
                  return _filter == 'Бүгд' || cat == _filter;
                }).toList();

                if (keys.isEmpty) {
                  return const Center(child: Text('Даалгавар алга байна'));
                }

                return ListView.builder(
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final key = keys[index];
                    final item = box.get(key) as Map;
                    final done = item['done'] as bool;
                    return ListTile(
                      leading: Checkbox(
                        value: done,
                        onChanged: (_) => _toggleDone(key, item),
                      ),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(
                          decoration: done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle: Text(item['category'] ?? 'Хувийн'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTodo(key),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
