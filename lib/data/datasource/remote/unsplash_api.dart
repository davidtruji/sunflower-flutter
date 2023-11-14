import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sunflower_flutter/data/datasource/remote/remote.dart';

import '../../../domain/model/unsplash_search_result.dart';

class UnsplashAPI extends Remote {
  static const String baseURL = "api.unsplash.com";
  static const String apiKey = "0H57RS-bnLp8XEz3INXHQRA2DU1m7mDL5yCIvi2U4rE";
  static const int pageSize = 20;

  @override
  Future<UnsplashSearchResults> fetchGallery(String query, int page) async {
    final queryParameters = {
      'query': query,
      'client_id': apiKey,
      'page': page.toString(),
      'per_page': pageSize.toString(),
    };

    final uri = Uri.https(baseURL, '/search/photos', queryParameters);

    final response = await http.get(uri);

    return UnsplashSearchResults.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
