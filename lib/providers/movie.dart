import 'package:flutter/widgets.dart';
import 'package:movies/model/movieModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie with ChangeNotifier {
  List<MovieModel> loadData = [];
  List<MovieModel> loadDataSearch = [];
  var extractSearchData;
  String title;
  String date;
  Future<void> fetchAndSetData() async {
    final url =
        'https://api.themoviedb.org/3/trending/all/day?api_key=43f478a941d6f958973b0fb466dcefe1';
    final response = await http.get(url);
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    if (extractData == null) {
      return;
    }
    print(extractData);
    for (int i = 0; i < extractData['results'].length; i++) {
      print(i);
      if (extractData['results'][i]['original_title'] == null) {
        title = extractData['results'][i]['original_name'];
      } else if (extractData['results'][i]['original_title'] == '기생충') {
        title = 'batman';
      } else {
        title = extractData['results'][i]['original_title'];
      }
      var url2 = 'http://www.omdbapi.com/?t=$title&apikey=cbecb1d4';
      final response2 = await http.get(url2);
      final extractData2 = json.decode(response2.body) as Map<String, dynamic>;
      print(title);
      print(extractData2['Poster']);
      loadData.add(MovieModel(
        title: title,
        id: extractData2['imdbID'],
        mediaType: extractData2['Type'],
        actors: extractData2['Actors'],
        releaseDate: extractData2['Released'],
        voteAverage: extractData2['imdbRating'],
        overview: extractData2['Plot'],
        movieImage: extractData2['Poster'],
        director: extractData2['Director'],
        language: extractData2['Language'],
        runtime: extractData2['Runtime'],
        genre: extractData2['Genre'],
      ));
    }
  }

  Future<void> setAndFetchSearchResult(String title) async {
    try {
      var url = 'http://www.omdbapi.com/?t=$title&apikey=cbecb1d4';
      final response = await http.get(url);

      extractSearchData = json.decode(response.body) as Map<String, dynamic>;

      if (extractSearchData['Response'] == 'False') {
        return;
      }

      loadDataSearch.add(MovieModel(
        id: extractSearchData['imdbID'],
        mediaType: extractSearchData['Type'],
        actors: extractSearchData['Actors'],
        title: extractSearchData['Title'],
        releaseDate: extractSearchData['Released'],
        voteAverage: extractSearchData['imdbRating'],
        overview: extractSearchData['Plot'],
        movieImage: extractSearchData['Poster'],
        director: extractSearchData['Director'],
        language: extractSearchData['Language'],
        runtime: extractSearchData['Runtime'],
        genre: extractSearchData['Genre'],
      ));
    } catch (err) {
      throw err;
    }
  }
}
