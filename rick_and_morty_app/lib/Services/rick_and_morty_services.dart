import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/Domain/Models/response.dart';

final class RickAndMortyServices {
  Future<Response> fetchData() async {
    final url = Uri.parse('https://rickandmortyapi.com/api/character');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Response.fromJson(jsonData);
    } else {
      throw Exception();
    }
  }
}
