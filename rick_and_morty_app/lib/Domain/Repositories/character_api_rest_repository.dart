import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Models/response.dart';
import 'package:rick_and_morty_app/Services/character_api_rest_services.dart';

final class CharacterAPIRestRepository {
  CharacterAPIRestRepository({required this.apiRestService});

  List<CharacterModel> _characterList = [];

  final CharacterAPIRestServices apiRestService;
  final String _baseURL = 'https://rickandmortyapi.com/api/character/';

  late CharacterResponseModel characterResponseModel;

  Future<List<CharacterModel>> getCharacters(
      {bool enablePagination = false}) async {
    final url = enablePagination ? characterResponseModel.info.next : _baseURL;
    final data = await apiRestService.fetchData(urlString: url);
    characterResponseModel = CharacterResponseModel.fromJson(data);
    _characterList = characterResponseModel.results;
    return Future.value(_characterList);
  }

  Future<CharacterModel> getCharacter({required int id}) async {
    final url = '$_baseURL$id';
    final data = await apiRestService.fetchData(urlString: url);
    final decodedData = CharacterModel.fromJson(data);
    return decodedData;
  }
}
