import 'package:flutter/material.dart';

/// Formats [value] with [decimals] decimal places, a [thousandsSeparator]
/// (use '' for none) and optional Arabic-Indic digits.
String formatCounterNumber(
  num value, {
  int decimals = 0,
  String thousandsSeparator = ',',
  String decimalSeparator = '.',
  bool arabicDigits = false,
}) {
  final negative = value < 0;
  final fixed = value.abs().toStringAsFixed(decimals);
  final parts = fixed.split('.');
  final whole = parts[0];
  final buffer = StringBuffer();
  for (var i = 0; i < whole.length; i++) {
    if (i > 0 && (whole.length - i) % 3 == 0) buffer.write(thousandsSeparator);
    buffer.write(whole[i]);
  }
  var text = buffer.toString();
  if (parts.length > 1) text += '$decimalSeparator${parts[1]}';
  if (negative) text = '-$text';
  if (arabicDigits) {
    const digits = '٠١٢٣٤٥٦٧٨٩';
    text = text.replaceAllMapped(
      RegExp('[0-9]'),
      (m) => digits[m[0]!.codeUnitAt(0) - 48],
    );
  }
  return text;
}

/// A number that animates from its previous value to [value].
///
/// ```dart
/// AnimatedCounterText(value: total, prefix: '\$', decimals: 2)
/// ```
class AnimatedCounterText extends StatelessWidget {
  /// Creates the counter.
  const AnimatedCounterText({
    super.key,
    required this.value,
    this.decimals = 0,
    this.prefix = '',
    this.suffix = '',
    this.thousandsSeparator = ',',
    this.decimalSeparator = '.',
    this.arabicDigits = false,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeOutCubic,
    this.animateOnFirstBuild = true,
    this.style,
    this.textAlign,
  });

  /// The number to show.
  final num value;

  /// Decimal places.
  final int decimals;

  /// Text before the number, e.g. a currency sign.
  final String prefix;

  /// Text after the number, e.g. '%' or ' EGP'.
  final String suffix;

  /// Thousands separator. Use '' for none.
  final String thousandsSeparator;

  /// Decimal separator.
  final String decimalSeparator;

  /// Whether to use Arabic-Indic digits (٠–٩).
  final bool arabicDigits;

  /// Animation duration.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  /// Whether to count up from 0 the first time it is shown.
  final bool animateOnFirstBuild;

  /// Text style. Tabular figures are added so digits do not jump around.
  final TextStyle? style;

  /// Text alignment.
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: animateOnFirstBuild ? 0 : value.toDouble(),
        end: value.toDouble(),
      ),
      duration: duration,
      curve: curve,
      builder: (context, v, _) => Text(
        '$prefix${formatCounterNumber(
          v,
          decimals: decimals,
          thousandsSeparator: thousandsSeparator,
          decimalSeparator: decimalSeparator,
          arabicDigits: arabicDigits,
        )}$suffix',
        style: base.copyWith(
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
        textAlign: textAlign,
      ),
    );
  }
}
