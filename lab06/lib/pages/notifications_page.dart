import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.campaign, color: Colors.blue),
          title: Text('Хичээл сонголт 1 эхэллээ.'),
          subtitle: Text('Өнөөдөр'),
        ),
        ListTile(
          leading: Icon(Icons.assignment, color: Colors.blue),
          title: Text('Бие даалтын даалгавар орууллаа.'),
          subtitle: Text('2 өдрийн өмнө'),
        ),
        ListTile(
          leading: Icon(Icons.event, color: Colors.blue),
          title: Text('Оюутны тэтгэлэгт хөтөлбөр зарлагдлаа.'),
          subtitle: Text('4 өдрийн өмнө'),
        ),
      ],
    );
  }
}
