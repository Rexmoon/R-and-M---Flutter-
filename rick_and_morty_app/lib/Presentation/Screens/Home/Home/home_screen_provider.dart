import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_api_rest_repository.dart';
import 'package:rick_and_morty_app/Services/connection_checker_services.dart';

final class HomeScreenProvider extends ChangeNotifier
    with ConnectionCheckerServicesMixin {
  HomeScreenProvider({required CharacterAPIRestRepository repository})
      : _repository = repository;

  final CharacterAPIRestRepository _repository;

  List<CharacterModel> _characters = [];

  List<CharacterModel> get characters => _characters;

  int currentPage = 1;

  bool hasInternetConnection = false;

  Future<void> loadData({bool enablePagination = false}) async {
    await checkConnection();

    final characters =
        await _repository.getCharacters(enablePagination: enablePagination);

    if (enablePagination) {
      _characters.addAll(characters);
    } else {
      _characters = characters;
    }

    notifyListeners();
  }

  bool canLoadMore() {
    return _repository.characterResponseModel.info.next != null;
  }

  // Internet connection checker service mixin

  Future<void> checkConnection() async {
    hasInternetConnection = await hasConnection;
    notifyListeners();
  }
}
