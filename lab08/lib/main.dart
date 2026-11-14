import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Article {
  final int id;
  final String title;
  final String description;

  Article({required this.id, required this.title, required this.description});

  String get imageUrl => 'https://picsum.photos/seed/$id/400/250';

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Гарчиггүй',
      description: json['body'] ?? '',
    );
  }
}

Future<List<Article>> fetchArticles() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((e) => Article.fromJson(e)).toList();
  } else {
    throw Exception('Мэдээ татахад алдаа гарлаа');
  }
}

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsListPage(),
    );
  }
}

// ---------- Жагсаалтын дэлгэц ----------
class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лаб №8 - Мэдээ'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          // 1) Ачаалж буй
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2) Алдаатай
          if (snapshot.hasError) {
            return Center(child: Text('Алдаа: ${snapshot.error}'));
          }
          // 3) Амжилттай
          final articles = snapshot.data ?? [];
          if (articles.isEmpty) {
            return const Center(child: Text('Мэдээ олдсонгүй'));
          }
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Image.network(
                    article.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        const Icon(Icons.article, color: Colors.blue),
                  ),
                  title: Text(article.title,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(article.description,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailPage(article: article),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final Article article;
  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дэлгэрэнгүй'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.imageUrl,
                width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(article.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(article.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
