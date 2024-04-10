import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_favorites_repository.dart';

final class FavoriteScreenProvider extends ChangeNotifier {
  FavoriteScreenProvider({required this.favoritesrepository});

  List<CharacterModel> _favorites = [];
  final CharacterFavoriteRepository favoritesrepository;

  List<CharacterModel> get favorites => _favorites;

  Future<void> loadData() async {
    _favorites = await favoritesrepository.read();
    notifyListeners();
  }
}
