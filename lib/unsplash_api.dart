import 'dart:convert';
import 'package:sunflower_flutter/unsplash_search_result.dart';
import 'package:http/http.dart' as http;

class UnsplashAPI {
  static const String BASE_URL = "api.unsplash.com";
  static const String API_KEY = "0H57RS-bnLp8XEz3INXHQRA2DU1m7mDL5yCIvi2U4rE";
  static const int PAGE_SIZE = 10;

  Future<UnsplashSearchResults> fetchGallery(String query, int page) async {
    final queryParameters = {
      'query': query,
      'client_id': API_KEY,
      'page': page.toString(),
      'per_page': PAGE_SIZE.toString(),
    };

    final uri = Uri.https(BASE_URL, '/search/photos', queryParameters);

    final response = await http.get(uri);

    return UnsplashSearchResults.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
