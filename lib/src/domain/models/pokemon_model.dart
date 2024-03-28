import 'dart:convert';

import 'package:flutter/material.dart';

import '../../application/extensions/string_extension.dart';

part 'pokemon_model.map.dart';

@immutable
class PokemonModel {
  const PokemonModel({
    int? id,
    required String name,
    List<String>? sprites,
    List<String>? types,
  })  : _id = id,
        _name = name,
        _sprites = sprites,
        _types = types;

  factory PokemonModel.fromJson(String source) => fromMap(json.decode(source) as Map<String, dynamic>);

  final int? _id;
  final String _name;
  final List<String>? _sprites;
  final List<String>? _types;

  int get id => _id ?? 0;
  String get name => _name;
  List<String> get sprites => _sprites ?? <String>[];
  List<String> get types => _types?.toSet().toList() ?? <String>[];
  String get officialArtwork => sprites.isNotEmpty ? sprites.elementAt(0) : '';
  String get showdown => sprites.isNotEmpty ? sprites.elementAt(1) : '';
  String get primaryType => types.isNotEmpty ? types.first : '';
  String get secondaryType => types.isNotEmpty ? types.last : '';
  Color get primaryColor => _getColorByType(primaryType);
  Color get secondaryColor => _getColorByType(secondaryType);

  Color _getColorByType(String type) {
    final Map<String, Color?> colors = <String, Color?>{
      'Bug': const Color(0xFFC0CA33),
      'Dark': const Color(0xFF424242),
      'Dragon': const Color(0xFF283593),
      'Electric': const Color(0xFFFFC107),
      'Fairy': const Color(0xFFFF80AB),
      'Fighting': const Color(0xFFB71C1C),
      'Fire': const Color(0xFFFF9800),
      'Flying': const Color(0xFF9FA8DA),
      'Ghost': const Color(0xFF5C6BC0),
      'Grass': const Color(0xFF4CAF50),
      'Ground': const Color(0xFFE65100),
      'Ice': const Color(0xFF4CD1C0),
      'Normal': const Color(0xFF9E9E9E),
      'Poison': const Color(0xFF9C27B0),
      'Psychic': const Color(0xFFFF6675),
      'Rock': const Color(0xFFC8B686),
      'Steel': const Color(0xFF607D8B),
      'Water': const Color(0xFF2196F3),
    };
    return colors[type.capitalize] ?? Colors.white10;
  }

  PokemonModel copyWith({
    int? id,
    String? name,
    List<String>? sprites,
    List<String>? types,
  }) {
    return PokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sprites: sprites ?? this.sprites,
      types: types ?? this.types,
    );
  }

  String toJson() => json.encode(toMap(this));

  @override
  String toString() {
    return toMap(this).toString();
  }
}
