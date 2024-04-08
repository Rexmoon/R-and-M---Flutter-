import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/rick_and_morty_repository.dart';

final class HomeScreenProvider with ChangeNotifier {
  final CharacterAPIRestRepository repository;

  HomeScreenProvider({required this.repository});

  List<CharacterModel> _characters = [];

  List<CharacterModel> get characters => _characters;

  int currentPage = 1;

  Future<void> loadData({bool enablePagination = false}) async {
    try {
      final characters =
          await repository.getCharacters(enablePagination: enablePagination);

      if (enablePagination) {
        _characters.addAll(characters);
      } else {
        _characters = characters;
      }

      notifyListeners();
    } on Exception catch (e) {
      Exception(e);
    }
  }

  bool canLoadMore() {
    return repository.characterResponseModel.info.next != null;
  }
}
