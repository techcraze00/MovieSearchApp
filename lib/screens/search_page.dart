import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/search_bar.dart' as custom_search_bar;  // Add an alias for your custom SearchBar
import '../screens/movie_list.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 207, 207),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 161, 161, 161),
        title: Text('Home'),
      ),
      body: Column(
        children: [
          custom_search_bar.SearchBar( // Use alias to reference your custom SearchBar
            onSearch: (query) => movieProvider.fetchMovies(query),
          ),
          Expanded(
            child: MovieList(),
          ),
        ],
      ),
    );
  }
}
