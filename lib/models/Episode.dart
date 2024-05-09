class Episode {
  final String id;
  final String title;
  final String description;
  final String imageUrl_1;
  final String imageUrl_poster;
  final String imageUrl_thumbnail;
  final String hlsFileId;
  final String encodedFilePath;
  final int updatedAt;

  Episode({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl_1,
    required this.imageUrl_poster,
    required this.imageUrl_thumbnail,
    required this.hlsFileId,
    required this.encodedFilePath,
    required this.updatedAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      title: json['title'],
      description: json['desc'],
      imageUrl_1: json['image_1_1'],
      imageUrl_poster: json['image_16_9'],
      imageUrl_thumbnail: json['imageUrl_thumbnail'],
      hlsFileId: json['hlsFileId'],
      encodedFilePath: json['encoded_file_path'],
      updatedAt: json['updatedAt'],
    );
  }
}
