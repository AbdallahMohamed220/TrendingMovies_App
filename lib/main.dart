import 'package:flutter/material.dart';
import 'package:movies/providers/movie.dart';
import 'package:movies/screens/homepage.dart';
import 'package:movies/screens/movieDetails.dart';
import 'package:movies/screens/movieSearchDetails.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Movie>(
      create: (context) => Movie(),
      child: MaterialApp(
        home: HomePage(),
        routes: {
          MovieDetails.routeName: (context) => MovieDetails(),
          MovieSearchDetails.routeName: (context) => MovieSearchDetails()
        },
      ),
    );
  }
}
