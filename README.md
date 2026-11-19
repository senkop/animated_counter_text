# animated_counter_text

[![pub package](https://img.shields.io/pub/v/animated_counter_text.svg)](https://pub.dev/packages/animated_counter_text)
[![CI](https://github.com/senkop/animated_counter_text/actions/workflows/ci.yml/badge.svg)](https://github.com/senkop/animated_counter_text/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A number that counts smoothly to its new value. Great for dashboards, totals and stats. No dependencies.

- Counts up on first show, then animates between values
- Decimals, thousands separators, prefix and suffix
- Arabic-Indic digits: ١٢٨,٤٥٠
- Tabular figures so the text does not jitter
- `formatCounterNumber` helper for formatting without animation

![animated_counter_text preview](https://raw.githubusercontent.com/senkop/animated_counter_text/main/doc/preview.svg)

## Install

```bash
flutter pub add animated_counter_text
```

## Usage

```dart
import 'package:animated_counter_text/animated_counter_text.dart';

AnimatedCounterText(value: total, prefix: r'$', decimals: 2)

AnimatedCounterText(
  value: orders,
  suffix: ' طلب',
  arabicDigits: true,
  style: Theme.of(context).textTheme.displaySmall,
)
```

## Example

```bash
cd example
flutter create .
flutter run -d chrome
```

## License

MIT
