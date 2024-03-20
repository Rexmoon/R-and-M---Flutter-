import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Models/info.dart';

final class Response {
  Info info;
  List<Character> results;

  Response({
    required this.info,
    required this.results,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        info: Info.fromJson(json["info"]),
        results: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
