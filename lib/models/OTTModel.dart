import 'package:hive/hive.dart';
part 'OTTModel.g.dart';

@HiveType(typeId: 1)
class OTTModel {
  @HiveField(0)
  final String ottName;
  @HiveField(1)
  final String websiteName;
  @HiveField(2)
  final String logoUrl;
  @HiveField(3)
  final String apiUrl;
  @HiveField(4)
  final String bucketUrl;

  OTTModel({
    required this.ottName,
    required this.websiteName,
    required this.logoUrl,
    required this.apiUrl,
    required this.bucketUrl,
  });

  factory OTTModel.fromJson(Map<String, dynamic> json) {
    return OTTModel(
      ottName: json['ott_name'],
      websiteName: json['website_name'],
      logoUrl: json['logo_url'],
      apiUrl: json['apiUrl'],
      bucketUrl: json['bucket_url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ott_name': ottName,
      'website_name': websiteName,
      'logo_url': logoUrl,
      'apiUrl': apiUrl,
      'bucket_url': bucketUrl,
    };
  }

  @override
  String toString() {
    return 'OTTModel{ ottName: $ottName, websiteName: $websiteName, logoUrl: $logoUrl, apiUrl: $apiUrl, bucketUrl: $bucketUrl }';
  }
}
