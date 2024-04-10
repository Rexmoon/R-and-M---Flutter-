import 'dart:convert';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Services/character_favorites_services.dart';

final class CharacterFavoriteRepository {
  CharacterFavoriteRepository({required CharacterFavoritesServices services})
      : _services = services;

  final CharacterFavoritesServices _services;
  List<CharacterModel> _favorites = [];

  List<CharacterModel> get favorites {
    _services.getPreferencesInstance();
    return _favorites;
  }

  Future<List<CharacterModel>> save({required CharacterModel character}) async {
    if (await isFavorite(id: character.id)) {
      _favorites.removeWhere((element) => element.id == character.id);
    } else {
      _favorites.insert(0, character);
    }

    await Future.delayed(const Duration(seconds: 1));

    final listString = jsonEncode(
        _favorites.map<Map<String, dynamic>>((e) => e.toJson()).toList());

    final _ = await _services.save(data: listString);

    return _favorites;
  }

  Future<List<CharacterModel>> read() async {
    final data = _services.read();
    if (data != null) {
      _favorites = (json.decode(data) as List<dynamic>)
          .map<CharacterModel>((item) => CharacterModel.fromJson(item))
          .toList();
    }

    return _favorites;
  }

  Future<bool> isFavorite({required int id}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_favorites.isEmpty) return false;
    final index = _favorites.indexWhere((character) => character.id == id);
    return index != -1;
  }
}
