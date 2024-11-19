import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          hintText: 'Search movies...',
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(Icons.search, color: Color(0xFF5EC570)), // Search icon inside the text field
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (query) => onSearch(query),
      ),
    );
  }
}
