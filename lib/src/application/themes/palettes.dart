import 'package:flutter/material.dart';

final class Palettes extends ThemeExtension<Palettes> {
  Palettes({
    this.primaryColor,
    this.secondaryColor,
    this.tertiaryColor,
    this.backgroundColor,
    this.cardColor,
    this.successColor,
    this.errorColor,
  });

  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? tertiaryColor;
  final Color? backgroundColor;
  final Color? cardColor;
  final Color? successColor;
  final Color? errorColor;

  @override
  ThemeExtension<Palettes> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? backgroundColor,
    Color? cardColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return Palettes(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      tertiaryColor: tertiaryColor,
      backgroundColor: backgroundColor,
      cardColor: cardColor,
      successColor: successColor,
      errorColor: errorColor,
    );
  }

  @override
  ThemeExtension<Palettes> lerp(ThemeExtension<Palettes>? other, double t) {
    if (other is! Palettes) {
      return this;
    }

    return Palettes(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      cardColor: Color.lerp(cardColor, other.cardColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
    );
  }

  static Palettes get light {
    return Palettes(
      primaryColor: Colors.white,
      secondaryColor: Colors.grey[800],
      tertiaryColor: Colors.transparent,
      backgroundColor: Colors.white,
      cardColor: Colors.grey[100],
      successColor: Colors.tealAccent[700],
      errorColor: Colors.redAccent,
    );
  }

  static Palettes get dark {
    return Palettes(
      primaryColor: Colors.grey[800],
      secondaryColor: Colors.white,
      tertiaryColor: Colors.transparent,
      backgroundColor: Colors.grey[900],
      cardColor: Colors.grey[850],
      successColor: Colors.tealAccent[700],
      errorColor: Colors.redAccent,
    );
  }

  Color get grey80 => secondaryColor!.withOpacity(0.8);
  Color get grey60 => secondaryColor!.withOpacity(0.6);
  Color get grey40 => secondaryColor!.withOpacity(0.4);
  Color get grey20 => secondaryColor!.withOpacity(0.2);
  Color get black26 => Colors.black26;
  Color get white24 => Colors.white24;
  Color get red => Colors.redAccent;
  Color get green => Colors.tealAccent[700]!;
  Color get blue => Colors.blue[400]!;
  Color get yellow => Colors.amber[400]!;
  Color get purple => Colors.purple[700]!;
  Color get brown => Colors.brown[400]!;
}
