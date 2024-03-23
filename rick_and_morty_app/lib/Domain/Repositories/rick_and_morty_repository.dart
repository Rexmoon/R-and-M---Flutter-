import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Models/response.dart';
import 'package:rick_and_morty_app/Services/rick_and_morty_services.dart';

final class RickAndMortyRepository {
  final _service = RickAndMortyServices();

  Future<List<Character>> getCharacters() async {
    try {
      final data = await _service.fetchData();
      final decodedData = CharacterResponse.fromJson(data);
      return decodedData.results;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }
}
