import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Services/rick_and_morty_services.dart';

final class HomeScreenProvider with ChangeNotifier {
  final RickAndMortyServices service = RickAndMortyServices();
  List<Character> characters = <Character>[];

  Future<void> loadData() async {
    final character = await service.fetchData();
    characters = character.results.toList();
    notifyListeners();
  }
}
