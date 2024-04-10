import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_api_rest_repository.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_favorites_repository.dart';

final class DetailScreenProvider extends ChangeNotifier {
  DetailScreenProvider(
      {required CharacterAPIRestRepository characterAPIRestRepository,
      required CharacterFavoriteRepository characterFavoriteRepository})
      : _characterAPIRestRepository = characterAPIRestRepository,
        _characterFavoriteRepository = characterFavoriteRepository;

  final CharacterAPIRestRepository _characterAPIRestRepository;
  final CharacterFavoriteRepository _characterFavoriteRepository;

  bool isFavorite = false;

  CharacterModel? _character;

  CharacterModel? get character => _character;

  Future<void> loadData({required int id}) async {
    _character = await _characterAPIRestRepository.getCharacter(id: id);
    isFavorite = await _characterFavoriteRepository.isFavorite(id: id);
    notifyListeners();
  }

  Future<void> saveAsFavorite() async {
    if (_character == null) return;
    await _characterFavoriteRepository.save(character: _character!);
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
