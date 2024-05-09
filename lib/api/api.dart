import 'dart:convert';
import 'package:ott_code_frontend/enviorment_var.dart';
import 'package:ott_code_frontend/models/Casts.dart';
import 'package:ott_code_frontend/models/Categories.dart';
import 'package:ott_code_frontend/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'package:ott_code_frontend/models/OTTModel.dart';
import 'package:ott_code_frontend/models/Song.dart';

class Api {
  static const _tendingUri =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${EnvironmentVars.api_key}';

  static const _upcomingMoviesUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${EnvironmentVars.api_key}';

  static const _topratedMovies =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${EnvironmentVars.api_key}';

  static const _usersSignUpUrl = '${EnvironmentVars.apiUrl}/api/v1/user/signup';
  static const _usersLoginUrl = '${EnvironmentVars.apiUrl}/api/v1/user/login';
  static const _otpVerfifyUrl =
      '${EnvironmentVars.apiUrl}/api/v1/user/verify_otp';

  static const _categoriesUrl =
      '${EnvironmentVars.apiUrl}/api/v1/admin/content/category';

  static String movieCredits(int movieId) {
    var baseUrl = EnvironmentVars.baseUrl;
    return '$baseUrl/movie/$movieId/credits?api_key=${EnvironmentVars.api_key}&language=en-US';
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_tendingUri));
    if (response.statusCode == 200) {
      final decodedData =
          json.decode(response.body)['results'] as List; // entire json from api
      //print(decodedData);
      return decodedData
          .map((movieResponse) => Movie.fromJson(movieResponse))
          .toList();
    } else {
      throw Exception("Something bad happens");
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData =
          json.decode(response.body)['results'] as List; // entire json from api

      return decodedData
          .map((movieResponse) => Movie.fromJson(movieResponse))
          .toList();
    } else {
      throw Exception("Something bad happens");
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topratedMovies));
    if (response.statusCode == 200) {
      final decodedData =
          json.decode(response.body)['results'] as List; // entire json from api

      return decodedData
          .map((movieResponse) => Movie.fromJson(movieResponse))
          .toList();
    } else {
      throw Exception("Something bad happens");
    }
  }

  Future<List<Casts>> getMovieCasts(int movieId) async {
    final response = await http.get(Uri.parse(movieCredits(movieId)));
    if (response.statusCode == 200) {
      final decodedData =
          json.decode(response.body)['cast'] as List; // entire json from api

      // if (kDebugMode) {
      //   print(decodedData);
      // }
      return decodedData
          .map((castResponse) => Casts.fromJson(castResponse))
          .toList();
    } else {
      throw Exception("Something bad happens");
    }
  }

  Future<http.Response> registerUserData(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(_usersSignUpUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );
    print("inside API response ==> $response");
    return response;
  }

  Future<http.Response> loginUserData(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(_usersLoginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );
    return response;
  }

  Future<http.Response> otpVerfify(Map<String, dynamic> otpData) async {
    final response = await http.post(
      Uri.parse(_otpVerfifyUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(otpData),
    );
    return response;
  }

  Future<List<Categories>> getCategories({String? searchString}) async {
    try {
      final response = await http.get(Uri.parse(_categoriesUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> categoryList = jsonData['list'];
        List<Categories> categories = categoryList.map((json) {
          return Categories.fromJson(json);
        }).toList();

        if (searchString != null && searchString.isNotEmpty) {
          // Filter categories based on search criteria
          categories = categories.where((category) {
            // Check if any song title contains the searchString
            return category.songs.any((song) =>
                song.title.toLowerCase().contains(searchString.toLowerCase()));
          }).map((category) {
            // Filter songs within each category based on search criteria
            final List<Song> filteredSongs = category.songs
                .where((song) => song.title
                    .toLowerCase()
                    .contains(searchString.toLowerCase()))
                .toList();
            return Categories(
              id: category.id,
              title: category.title,
              description: category.description,
              type: category.type,
              genre: category.genre,
              portraitKey: category.portraitKey,
              thumbnailKey: category.thumbnailKey,
              createdAt: category.createdAt,
              songs: filteredSongs,
            );
          }).toList();
        }

        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      throw Exception('Failed to load categories: $error');
    }
  }

  Future<List<OTTModel>> parseOTTs(String responseBody) async {
    String res = '''
  [
    {
      "ott_name": "Indimuse",
      "website_name": "indimuse.in",
      "logo_url": "/assets/images/app_logo_new.png",
      "apiUrl": "dummy_url_here",
      "bucket_url": "dummy_url_here"
    },
    // {
    //   "ott_name": "Flutflix",
    //   "website_name": "flutflix.in",
    //   "logo_url": "/assets/images/app_logo_old.png",
    //   "apiUrl": "dummy_url_here",
    //   "bucket_url": "dummy_url_here"
    // }
  ]
  ''';

    final parsed = jsonDecode(res).cast<Map<String, dynamic>>();
    return parsed.map<OTTModel>((json) => OTTModel.fromJson(json)).toList();
  }
}
