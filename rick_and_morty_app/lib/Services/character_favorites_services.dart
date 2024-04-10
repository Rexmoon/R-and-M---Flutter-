import 'package:shared_preferences/shared_preferences.dart';

final class CharacterFavoritesServices {
  CharacterFavoritesServices._internal() {
    Future.wait([getPreferencesInstance()]);
  }

  static final CharacterFavoritesServices _singleton =
      CharacterFavoritesServices._internal();

  factory CharacterFavoritesServices() {
    return _singleton;
  }

  late SharedPreferences _preferences;

  final String _favoriteKey = 'FAVORITES_LIST_KEY';

  Future<void> getPreferencesInstance() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> save({required String data}) async {
    if (data.isEmpty) return false;
    return await _preferences.setString(_favoriteKey, data);
  }

  String? read() {
    return _preferences.getString(_favoriteKey);
  }
}
