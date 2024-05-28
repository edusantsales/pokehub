import '../../data/adapters/flutter_secure_storage_adapter.dart';
import '../../data/adapters/pokemon_api_adapter.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../../data/repositories/pokemon_storage.dart';
import '../../domain/interfaces/repositories/pokemon_repository_interface.dart';
import '../../domain/interfaces/repositories/pokemon_storage_interface.dart';

final class PokemonService {
  PokemonService()
      : _repository = PokemonRepository(PokemonApiAdapter()),
        _storage = PokemonStorage(FlutterSecureStorageAdapter());

  final PokemonRepositoryInterface _repository;
  final PokemonStorageInterface _storage;

  PokemonRepositoryInterface get repository => _repository;
  PokemonStorageInterface get storage => _storage;
}
