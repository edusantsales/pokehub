import 'package:flutter/material.dart';

final class Typographies extends ThemeExtension<Typographies> {
  Typographies({
    this.fontSize12,
    this.fontSize16,
    this.fontSize20,
    this.fontSize24,
    this.fontSize32,
    this.fontSize40,
    this.fontSize48,
  });

  final TextStyle? fontSize12;
  final TextStyle? fontSize16;
  final TextStyle? fontSize20;
  final TextStyle? fontSize24;
  final TextStyle? fontSize32;
  final TextStyle? fontSize40;
  final TextStyle? fontSize48;

  @override
  ThemeExtension<Typographies> copyWith({
    TextStyle? fontSize12,
    TextStyle? fontSize16,
    TextStyle? fontSize20,
    TextStyle? fontSize24,
    TextStyle? fontSize32,
    TextStyle? fontSize40,
    TextStyle? fontSize48,
  }) {
    return Typographies(
      fontSize12: fontSize12,
      fontSize16: fontSize16,
      fontSize20: fontSize20,
      fontSize24: fontSize24,
      fontSize32: fontSize32,
      fontSize40: fontSize40,
      fontSize48: fontSize48,
    );
  }

  @override
  ThemeExtension<Typographies> lerp(ThemeExtension<Typographies>? other, double t) {
    if (other is! Typographies) {
      return this;
    }

    return Typographies(
      fontSize12: TextStyle.lerp(fontSize12, other.fontSize12, t),
      fontSize16: TextStyle.lerp(fontSize16, other.fontSize16, t),
      fontSize20: TextStyle.lerp(fontSize20, other.fontSize20, t),
      fontSize24: TextStyle.lerp(fontSize24, other.fontSize24, t),
      fontSize32: TextStyle.lerp(fontSize32, other.fontSize32, t),
      fontSize40: TextStyle.lerp(fontSize40, other.fontSize40, t),
      fontSize48: TextStyle.lerp(fontSize48, other.fontSize48, t),
    );
  }

  static Typographies get inter {
    const TextStyle inter = TextStyle(fontFamily: 'Inter');
    return Typographies(
      fontSize12: inter.copyWith(fontSize: 12),
      fontSize16: inter.copyWith(fontSize: 16),
      fontSize20: inter.copyWith(fontSize: 20),
      fontSize24: inter.copyWith(fontSize: 24),
      fontSize32: inter.copyWith(fontSize: 32),
      fontSize40: inter.copyWith(fontSize: 40),
      fontSize48: inter.copyWith(fontSize: 48),
    );
  }
}
