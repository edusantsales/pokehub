import '../../data/adapters/flutter_secure_storage_adapter.dart';
import '../../data/adapters/pokemon_api_adapter.dart';
import '../../data/databases/pokemon_database.dart';
import '../../data/repositories/pokemon_repository.dart';
import '../../domain/interfaces/databases/pokemon_database_interface.dart';
import '../../domain/interfaces/repositories/pokemon_repository_interface.dart';

final class PokemonService {
  PokemonService()
      : _repository = PokemonRepository(PokemonApiAdapter()),
        _database = PokemonDatabase(FlutterSecureStorageAdapter());

  final PokemonRepositoryInterface _repository;
  final PokemonDatabaseInterface _database;

  PokemonRepositoryInterface get repository => _repository;
  PokemonDatabaseInterface get storage => _database;
}
