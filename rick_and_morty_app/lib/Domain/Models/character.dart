import 'package:flutter/material.dart';

final class CharacterModel {
  int id;
  String name;
  Status status;
  String? species;
  String? type;
  Gender? gender;
  LocationModel origin;
  LocationModel location;
  String image;
  List<String>? episode;
  String? url;
  DateTime? created; // Made created nullable using ?

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    this.created, // made created optional
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: json["species"] ?? '',
        type: json["type"] ?? '',
        gender: genderValues.map[json["gender"] ?? 'unknown']!,
        origin: LocationModel.fromJson(json["origin"]),
        location: LocationModel.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x) ?? []),
        url: json["url"] ?? '',
        created: json["created"] != null
            ? DateTime.parse(json["created"])
            : null, // Check for null before parsing
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": species,
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode":
            List<dynamic>.from(episode != null ? episode!.map((x) => x) : []),
        "url": url,
        "created": created
            ?.toIso8601String(), // Use safe navigation (?) to avoid errors with null
      };
}

enum Gender { female, male, unknown, genderless }

final genderValues = EnumValues({
  'Female': Gender.female,
  'Male': Gender.male,
  'unknown': Gender.unknown,
  'Genderless': Gender.genderless
});

final class LocationModel {
  String name;
  String url;

  LocationModel({
    required this.name,
    required this.url,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Species { alien, human, mythologicalCreature }

final speciesValues = EnumValues({
  "Alien": Species.alien,
  "Human": Species.human,
  'Mythological Creature': Species.mythologicalCreature
});

enum Status { alive, dead, unknown }

extension StatusColor on Status {
  Color get color {
    switch (this) {
      case Status.alive:
        return Colors.green;
      case Status.dead:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

final statusValues = EnumValues(
    {"Alive": Status.alive, "Dead": Status.dead, "unknown": Status.unknown});

final class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
