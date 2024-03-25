import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/rick_and_morty_repository.dart';

final class CharacterProvider with ChangeNotifier {
  final _repository = CharacterAPIRestRepository();

  List<CharacterModel> _characters = [];

  List<CharacterModel> get characters => _characters;

  Future<void> loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      _characters = await _repository.getCharacters();
      notifyListeners();
    } on Exception catch (e) {
      Exception(e);
    }
  }
}