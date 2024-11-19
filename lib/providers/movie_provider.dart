import 'package:flutter/material.dart';
import '../services/api_service.dart';  // Import ApiService to fetch data

class MovieProvider with ChangeNotifier {
  bool isLoading = false;
  List<Map<String, dynamic>> _movies = [];

  List<Map<String, dynamic>> get movies => _movies;

  Future<void> fetchMovies(String query) async {
    try {
      isLoading = true;
      notifyListeners();

      // Step 1: Fetch basic movie list based on query
      final movieList = await ApiService.fetchMovies(query);

      // Limit the number of movies to fetch detailed info for (e.g., 10 movies)
      final limitedMovieList = movieList.take(10).toList();

      // Step 2: Fetch detailed information for each movie in parallel
      final futures = limitedMovieList.map((movie) {
        return ApiService.fetchMovieDetails(movie['imdbID']);
      }).toList();

      // Wait for all movie detail fetches to complete
      final detailedMovies = await Future.wait(futures);

      // Map the detailed movies into the format required for display
      _movies = detailedMovies.map((movieDetails) {
        return {
          'Title': movieDetails['Title'] ?? 'Unknown Title',
          'Poster': movieDetails['Poster'] ?? '',
          'Genre': movieDetails['Genre'] ?? 'Unknown Genre',
          'imdbRating': movieDetails['imdbRating'] ?? 'N/A',
        };
      }).toList();
    } catch (error) {
      print(error);
      _movies = []; // Reset the movie list on error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
