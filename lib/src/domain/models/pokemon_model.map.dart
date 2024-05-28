part of 'pokemon_model.dart';

PokemonModel fromMap(Map<String, dynamic> map) {
  return PokemonModel(
    id: map['id'] as int?,
    name: map['name'] as String,
    sprites: <String>[
      map['sprites']['other']['official-artwork']['front_default'] as String,
      map['sprites']['other']['showdown']['front_default'] as String,
    ],
    types: <String>[
      (map['types'] as List<dynamic>).first['type']['name'] as String,
      (map['types'] as List<dynamic>).last['type']['name'] as String,
    ],
  );
}

Map<String, dynamic> toMap(PokemonModel map) {
  return <String, dynamic>{
    'id': map.id,
    'name': map.name,
    'sprites': map.sprites,
    'types': map.types,
  };
}
