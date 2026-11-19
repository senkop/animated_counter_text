import 'dart:math';

import 'package:animated_counter_text/animated_counter_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoPage()));

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  double _revenue = 128450.75;

  @override
  Widget build(BuildContext context) {
    final big = Theme.of(context).textTheme.displaySmall;
    return Scaffold(
      appBar: AppBar(title: const Text('animated_counter_text')),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            setState(() => _revenue = Random().nextDouble() * 250000),
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedCounterText(
              value: _revenue,
              prefix: r'$',
              decimals: 2,
              style: big,
            ),
            const SizedBox(height: 16),
            AnimatedCounterText(
              value: _revenue,
              suffix: ' ج.م',
              arabicDigits: true,
              style: big,
            ),
          ],
        ),
      ),
    );
  }
}
