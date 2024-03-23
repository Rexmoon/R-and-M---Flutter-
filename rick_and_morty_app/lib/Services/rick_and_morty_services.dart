import 'dart:convert';

import 'package:http/http.dart' as http;

final class RickAndMortyServices {
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final url = Uri.parse('https://rickandmortyapi.com/api/character');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error(Exception('Not data found!'));
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
