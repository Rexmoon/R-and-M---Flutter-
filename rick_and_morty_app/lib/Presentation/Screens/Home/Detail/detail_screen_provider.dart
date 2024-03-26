import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/rick_and_morty_repository.dart';

final class DetailScreenProvider extends ChangeNotifier {
  DetailScreenProvider({required this.characterAPIRestRepository});

  final CharacterAPIRestRepository characterAPIRestRepository;

  int _characterId = 0;

  CharacterModel? _character;

  CharacterModel? get character => _character;

  Future<void> loadData({required int id}) async {
    _characterId = id;
    try {
      _character =
          await characterAPIRestRepository.getCharacter(id: _characterId);
      notifyListeners();
    } catch (e) {
      Future.error(Exception(e));
    }
  }
}
