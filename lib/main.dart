import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'screens/search_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDB Search',
      theme: ThemeData.light(),
      home: SearchPage(),
    );
  }
}
