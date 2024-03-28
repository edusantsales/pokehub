import '../../data/adapters/http_adapter.dart';
import '../../data/adapters/local_storage_adapter.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../../data/repositories/pokemon_storage.dart';
import '../../domain/interfaces/repositories/pokemon_repository_interface.dart';
import '../../domain/interfaces/repositories/pokemon_storage_interface.dart';

final class DataService {
  DataService()
      : _pokemonRepository = PokemonRepository(HttpAdapter()),
        _pokemonStorage = PokemonStorage(LocalStorageAdapter());

  final PokemonRepositoryInterface _pokemonRepository;
  final PokemonStorageInterface _pokemonStorage;

  PokemonRepositoryInterface get pokemonRepository => _pokemonRepository;
  PokemonStorageInterface get pokemonStorage => _pokemonStorage;
}
