part of 'pokemon_model.dart';

PokemonModel fromMap(Map<String, dynamic> map) {
  return PokemonModel(
    id: map['id'] as int?,
    name: map['name'] as String,
    sprites: <String>[
      (((map['sprites'] as Map<String, dynamic>)['other'] as Map<String, dynamic>)['official-artwork']
          as Map<String, dynamic>)['front_default'] as String,
      (((map['sprites'] as Map<String, dynamic>)['other'] as Map<String, dynamic>)['showdown']
          as Map<String, dynamic>)['front_default'] as String,
    ],
    types: <String>[
      ((map['types'] as List<dynamic>).first['type'] as Map<String, dynamic>)['name'] as String,
      ((map['types'] as List<dynamic>).last['type'] as Map<String, dynamic>)['name'] as String,
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
