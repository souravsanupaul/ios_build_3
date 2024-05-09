import 'package:ott_code_frontend/models/Song.dart';

class Categories {
  final String id;
  final String title;
  final String description;
  final String type;
  final String genre;
  final String portraitKey;
  final String thumbnailKey;
  final int createdAt;
  final List<Song> songs;

  Categories({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.genre,
    required this.portraitKey,
    required this.thumbnailKey,
    required this.createdAt,
    required this.songs,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      title: json['title'],
      description: json['desc'],
      type: json['type'],
      genre: json['genre'],
      portraitKey: json['portrait_key'],
      thumbnailKey: json['thumbnail_key'],
      createdAt: json['created_at'],
      songs: (json['content'] as List<dynamic>?)?.map((songJson) {
            return Song.fromJson(songJson);
          }).toList() ??
          [],
    );
  }
}
