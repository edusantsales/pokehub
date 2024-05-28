import 'dart:convert';

import 'package:flutter/material.dart';

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

  String toJson() => json.encode(toMap(this));

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

  @override
  String toString() {
    return toMap(this).toString();
  }

  final int? _id;
  final String _name;
  final List<String>? _sprites;
  final List<String>? _types;

  int get id => _id ?? 0;
  String get name => _name;
  List<String> get sprites => _sprites ?? <String>[];
  List<String> get types => _getTypesDistinct();
  String get officialArtwork => sprites.first;
  String get showdown => sprites.last;
  String get primaryType => types.first;
  String get secondaryType => types.last;
  Color get primaryColor => _getColorByType(primaryType);
  Color get secondaryColor => _getColorByType(secondaryType);

  List<String> _getTypesDistinct() {
    return _types?.toSet().toList() ?? <String>[];
  }

  Color _getColorByType(String type) {
    final Map<String, Color?> colors = <String, Color?>{
      'bug': const Color(0xFFC0CA33),
      'dark': const Color(0xFF424242),
      'dragon': const Color(0xFF283593),
      'electric': const Color(0xFFFFC107),
      'fairy': const Color(0xFFFF80AB),
      'fighting': const Color(0xFFB71C1C),
      'fire': const Color(0xFFFF9800),
      'flying': const Color(0xFF9FA8DA),
      'ghost': const Color(0xFF5C6BC0),
      'grass': const Color(0xFF4CAF50),
      'ground': const Color(0xFFE65100),
      'ice': const Color(0xFF4CD1C0),
      'normal': const Color(0xFF9E9E9E),
      'poison': const Color(0xFF9C27B0),
      'psychic': const Color(0xFFFF6675),
      'rock': const Color(0xFFC8B686),
      'steel': const Color(0xFF607D8B),
      'water': const Color(0xFF2196F3),
    };
    return colors[type] ?? Colors.white10;
  }
}
