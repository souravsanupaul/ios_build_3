class Song {
  final String id;
  final String title;
  final String description;
  final String imageUrl_1;
  final String imageUrl_poster;
  final String imageUrl_thumbnail;
  final String hlsFileId;
  final String encodedFilePath;
  final int updatedAt;

  Song({
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

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'],
      title: json['title'],
      description: json['desc'],
      imageUrl_1: (json['image_1_1'] as Map<String, dynamic>)['key'],
      imageUrl_poster: (json['image_16_9'] as Map<String, dynamic>)['key'],
      imageUrl_thumbnail: (json['image_9_16'] as Map<String, dynamic>)['key'],
      hlsFileId: (json['media'][0]
          as Map<String, dynamic>)['hls_file_id'], // Extract hlsFileId
      encodedFilePath: (json['media'][0] as Map<String, dynamic>)[
          'encoded_file_path'], // Extract encodedFilePath
      updatedAt: json['updated_at'],
    );
  }
}
