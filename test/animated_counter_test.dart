import 'package:animated_counter_text/animated_counter_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats numbers', () {
    expect(formatCounterNumber(1234567), '1,234,567');
    expect(formatCounterNumber(999), '999');
    expect(formatCounterNumber(1234.5, decimals: 2), '1,234.50');
    expect(formatCounterNumber(-1500), '-1,500');
    expect(formatCounterNumber(1500, thousandsSeparator: ''), '1500');
    expect(formatCounterNumber(1250, arabicDigits: true), '١,٢٥٠');
  });

  testWidgets('counts up to the value', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AnimatedCounterText(value: 1200, prefix: r'$'),
    ));
    expect(find.text(r'$0'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text(r'$1,200'), findsOneWidget);
  });

  testWidgets('animates between values', (tester) async {
    Widget app(num v) => MaterialApp(
          home: AnimatedCounterText(value: v, animateOnFirstBuild: false),
        );
    await tester.pumpWidget(app(100));
    expect(find.text('100'), findsOneWidget);
    await tester.pumpWidget(app(200));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('200'), findsNothing);
    await tester.pumpAndSettle();
    expect(find.text('200'), findsOneWidget);
  });
}
