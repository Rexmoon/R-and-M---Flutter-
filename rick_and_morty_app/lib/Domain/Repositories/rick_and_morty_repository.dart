import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Models/response.dart';
import 'package:rick_and_morty_app/Services/rick_and_morty_services.dart';

final class CharacterAPIRestRepository {
  final CharacterAPIRestServices service;
  final String _baseURL = '/character/';

  CharacterAPIRestRepository({required this.service});

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final data = await service.fetchData(urlComplement: _baseURL);
      final decodedData = CharacterResponseModel.fromJson(data);
      return decodedData.results;
    } catch (e) {
      return Future.error(Exception(e));
    }
  }

  Future<CharacterModel> getCharacter({required int id}) async {
    final rawUrl = '$_baseURL$id';

    try {
      final data = await service.fetchData(urlComplement: rawUrl);
      final decodedData = CharacterModel.fromJson(data);
      return decodedData;
    } catch (e) {
      return Future.error(e);
    }
  }
}
