import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Models/info.dart';

final class CharacterResponseModel {
  InfoModel info;
  List<CharacterModel> results;

  CharacterResponseModel({
    required this.info,
    required this.results,
  });

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) =>
      CharacterResponseModel(
        info: InfoModel.fromJson(json["info"]),
        results: List<CharacterModel>.from(
            json["results"].map((x) => CharacterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
