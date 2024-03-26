import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Models/response.dart';
import 'package:rick_and_morty_app/Services/rick_and_morty_services.dart';

final class CharacterAPIRestRepository {
  final CharacterAPIRestServices service;
  final String _baseURL = 'https://rickandmortyapi.com/api/character/';

  late CharacterResponseModel characterResponseModel;

  CharacterAPIRestRepository({required this.service});

  Future<List<CharacterModel>> getCharacters(
      {bool enablePagination = false}) async {
    final url = enablePagination ? characterResponseModel.info.next : _baseURL;

    try {
      final data = await service.fetchData(urlString: url);
      characterResponseModel = CharacterResponseModel.fromJson(data);
      return characterResponseModel.results;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

  Future<CharacterModel> getCharacter({required int id}) async {
    final url = '$_baseURL$id';
    try {
      final data = await service.fetchData(urlString: url);
      final decodedData = CharacterModel.fromJson(data);
      return decodedData;
    } catch (e) {
      return Future.error(e);
    }
  }
}
