import 'dart:convert';
import 'package:uuid/uuid.dart';

Places placesFromJson(String str) => Places.fromJson(json.decode(str));

String placesToJson(Places data) => json.encode(data.toJson());

class Places {
  String id;
  String name;
  String description;

  Places({
    required this.name,
    required this.description,
  }) : id = const Uuid().v1();

  factory Places.fromJson(Map<String, dynamic> json) => Places(
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
