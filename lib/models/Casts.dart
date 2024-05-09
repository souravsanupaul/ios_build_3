class Casts {
  int id;
  String name;
  String profilePath;
  String originalName;
  String characterName;
  //named constructor
  Casts({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.originalName,
    required this.characterName,
  });

  // mapping json to field
  factory Casts.fromJson(Map<String, dynamic> json) {
    return Casts(
      id: json["id"] as int,
      name: json["name"],
      profilePath: json["profile_path"] ?? "",
      originalName: json["original_name"],
      characterName: json["character"],
    );
  }
}
