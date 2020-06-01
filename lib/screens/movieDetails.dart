import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/movie.dart';
import 'package:provider/provider.dart';

class MovieDetails extends StatelessWidget {
  static const routeName = '/movieDetail';
  @override
  Widget build(BuildContext context) {
    var loadMovies = Provider.of<Movie>(context).loadData;
    var moiveId = ModalRoute.of(context).settings.arguments;
    final selectetMovie = loadMovies.firstWhere((moive) => moive.id == moiveId);
    return Scaffold(
        body: ListView(
      itemExtent: 800,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.network(
              selectetMovie.movieImage,
              fit: BoxFit.fill,
              height: 400,
              width: double.infinity,
            ),
            Positioned(
              top: 380,
              left: 8,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Image.network(
                  selectetMovie.movieImage,
                  fit: BoxFit.fill,
                  height: 150,
                  width: 120,
                ),
              ),
            ),
            Positioned(
              top: 370,
              right: 12,
              child: CircleAvatar(
                radius: 25,
                child: Text(
                  selectetMovie.voteAverage.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrange,
              ),
            ),
            Positioned(
              top: 420,
              left: 150,
              child: AutoSizeText(
                selectetMovie.title.length > 20
                    ? selectetMovie.title.substring(0, 20)
                    : selectetMovie.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxFontSize: 20,
              ),
            ),
            Positioned(
              top: 450,
              left: 150,
              child: Text(
                "Director : ${selectetMovie.director}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 470,
              left: 150,
              child: Text(
                "Release time : ${selectetMovie.releaseDate}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 490,
              left: 150,
              child: Text(
                "Length : ${selectetMovie.runtime}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 510,
              left: 150,
              child: AutoSizeText(
                'Type: ${selectetMovie.genre.length > 27 ? selectetMovie.genre.substring(0, 28) : selectetMovie.genre}',
                style: TextStyle(
                  color: Colors.grey,
                ),
                maxFontSize: 15,
                softWrap: true,
                wrapWords: true,
              ),
            ),
            Positioned(
              top: 530,
              left: 150,
              child: Text(
                "Language : ${selectetMovie.language}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: 560,
              left: 12,
              child: Text(
                "Overview : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: 580,
              left: 10,
              child: Container(
                padding: EdgeInsets.only(right: 25, top: 8, bottom: 5),
                width: 370,
                height: 120,
                child: AutoSizeText(
                  '${selectetMovie.overview}',
                  maxLines: 5,
                  minFontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: 670,
              left: 12,
              child: Text(
                "Actors : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              top: 690,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(8),
                width: 370,
                height: 100,
                child: AutoSizeText(
                  '${selectetMovie.actors}',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 5,
                  minFontSize: 15,
                  maxFontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
