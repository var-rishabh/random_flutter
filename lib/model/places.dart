import 'dart:convert';

Places placesFromJson(String str) => Places.fromJson(json.decode(str));

String placesToJson(Places data) => json.encode(data.toJson());

class Places {
  String id;
  String name;
  String description;

  Places({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Places.fromJson(Map<String, dynamic> json) => Places(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
