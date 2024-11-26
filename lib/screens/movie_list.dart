import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
//
class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    if (movieProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (movieProvider.movies.isEmpty) {
      return Center(
        child: Text(
          'No movies found!',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600), // Limit width
          child: SingleChildScrollView( // Allow scrolling for the entire screen if needed
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevent stretching vertically
              children: [
                ListView.builder(
                  shrinkWrap: true, // Prevent ListView from taking all available space
                  padding: EdgeInsets.all(16.0),
                  itemCount: movieProvider.movies.length,
                  itemBuilder: (context, index) {
                    final movie = movieProvider.movies[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Movie Details Box
                          Container(
                            height: 300, // Fixed height
                            width: 550, // Fixed width
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 255, 255, 255), // Solid white background
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.bottomRight, // Align details to the bottom right
                              child: Container(
                                width: 550 - 15,
                                height: 200, // Fixed height for details
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 350-15, // Fixed width
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 255, 255, 255), // Background color
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        movie['Title'] ?? 'Unknown Title',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width < 600 ? 18 : 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      movie['Genre'] ?? 'Unknown Genre',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: _getRatingColor(movie['imdbRating']),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '${movie['imdbRating'] ?? 'N/A'} IMDB',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width < 600 ? 12 : 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Movie Poster Box
                          Positioned(
                            top: 5, // Padding from the top
                            left: 25, // Padding from the left
                            bottom: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              
                              child: movie['Poster'] != null
                                  ? Image.network(
                                      movie['Poster'],
                                      width: 144, // Fixed width
                                      height: 192, // 1:2 ratio (height = 2 * width)
                                      fit: BoxFit.fill,
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width < 600 ? 144 : 192,
                                      height: MediaQuery.of(context).size.width < 600 ? 180 : 240,
                                      //width: 144, // Fixed width
                                      //height: 192,
                                      color: Colors.grey,
                                      child: Icon(Icons.movie, color: Colors.white, size: 40),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to determine the color based on the IMDb rating
  Color _getRatingColor(String? imdbRating) {
    if (imdbRating == null || imdbRating == 'N/A') {
      return Colors.grey[700]!; // Default color if no rating
    }

    // Convert the rating to a double and check if it's greater than 7
    double rating = double.tryParse(imdbRating) ?? 0.0;
    if (rating >= 7) {
      return Color(0xFF5EC570); // Green for ratings >= 7
    } else {
      return Color(0xFF1C7EEB); // Blue for ratings < 7
    }
  }
}
