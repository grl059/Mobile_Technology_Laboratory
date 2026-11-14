import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lib/main.dart';

void main() {
  testWidgets('Hii Flutter хуудас зөв харагдана', (WidgetTester tester) async {
    await tester.pumpWidget(const HelloFlutterApp());

    expect(find.text('Лаб №1 - Hi Flutter'), findsOneWidget);
    expect(find.text('Hii, Flutter '), findsOneWidget);
    expect(find.text('А. Гэрэл B241940001'), findsOneWidget);
    expect(find.byIcon(Icons.cruelty_free), findsOneWidget);
  });
}