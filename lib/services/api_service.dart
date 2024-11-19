import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = '908da38b'; // Replace with your API key
  static const String _baseUrl = 'https://www.omdbapi.com/';

  // Fetch basic list of movies (with title and poster)
  static Future<List<dynamic>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?apikey=$_apiKey&s=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['Search'] != null) {
        return data['Search'];
      }
    }
    throw Exception('Failed to fetch movies');
  }

  // Fetch detailed movie information based on imdbID
  static Future<Map<String, dynamic>> fetchMovieDetails(String imdbID) async {
    final response = await http.get(Uri.parse('$_baseUrl?apikey=$_apiKey&i=$imdbID'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data; // Return the detailed movie data
    }
    throw Exception('Failed to fetch movie details');
  }
}
