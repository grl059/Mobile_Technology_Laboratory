import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab03/main.dart';

void main() {
  testWidgets('Weather Dashboard simplified smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());
    expect(find.text('Улаанбаатар'), findsOneWidget);
    expect(find.text('+18°C'), findsOneWidget);
    expect(find.text('Чийгшил'), findsOneWidget);
    expect(find.text('Салхины хурд'), findsOneWidget);
    expect(find.text('Ойрын өдрүүд'), findsOneWidget);
    expect(find.text('Баасан'), findsOneWidget);
  });
}