import 'package:flutter/material.dart';
import 'package:movies/model/movieModel.dart';
import 'package:movies/providers/movie.dart';
import 'package:movies/screens/movieSearchDetails.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  bool _isloading = false;
  bool _text = true;
  String id = '';
  List<MovieModel> loadData = [];

  clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchController.clear());
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search for a movie...',
          prefixIcon: Icon(Icons.movie),
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handelSearch,
      ),
    );
  }

  handelSearch(String query) async {
    loadData.clear();
    setState(() {
      _isloading = true;
    });
    String title = searchController.text;

    await Provider.of<Movie>(context, listen: false)
        .setAndFetchSearchResult(title);
    if (Provider.of<Movie>(context, listen: false)
            .extractSearchData['Response'] ==
        'False') {
      setState(() {
        _isloading = false;
        _text = false;
      });
    } else {
      loadData = Provider.of<Movie>(context, listen: false).loadDataSearch;
      id = Provider.of<Movie>(context, listen: false)
          .extractSearchData['imdbID'];
    }
    // var url = 'http://www.omdbapi.com/?t=$title&apikey=cbecb1d4';
    // final response = await http.get(url);

    // final extractData = json.decode(response.body) as Map<String, dynamic>;
    // print(extractData['Response']);
    // if (extractData['Response'] == 'False') {
    //   print(null);
    //   setState(() {
    //     _isloading = false;
    //     _text = false;
    //   });
    //   return;
    // }

    // loadData.add(MovieModel(
    //   id: extractData['imdbID'],
    //   mediaType: extractData['Type'],
    //   actors: extractData['Actors'],
    //   title: extractData['Title'],
    //   releaseDate: extractData['Released'],
    //   voteAverage: extractData['imdbRating'],
    //   overview: extractData['Plot'],
    //   movieImage: extractData['Poster'],
    //   director: extractData['Director'],
    //   language: extractData['Language'],
    //   runtime: extractData['Runtime'],
    //   genre: extractData['Genre'],
    // ));
    setState(() {
      _isloading = false;
    });
  }

  Container buildNoContent() {
    return Container(
      child: Center(
          child: _text
              ? Text(
                  "",
                )
              : Text(
                  "Not Found ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
    );
  }

  void selectMovie(BuildContext context) {
    Navigator.of(context).pushNamed(
      MovieSearchDetails.routeName,
      arguments: id,
    );
  }

  buildSearchResult() {
    return loadData.length == 0
        ? buildNoContent()
        : ListView.builder(
            itemCount: loadData.length,
            itemBuilder: (ctx, i) => Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(i),
              background: Container(
                color: Theme.of(context).accentColor,
                child: Icon(
                  Icons.delete,
                  size: 30,
                  color: Theme.of(context).cardColor,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    onTap: () => selectMovie(context),
                    title: Text(loadData[i].title),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(loadData[i].movieImage),
                    ),
                    trailing: CircleAvatar(
                      child: Text(loadData[i].voteAverage.toString()),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                    ),
                    subtitle: Text('Director: ${loadData[i].director}'),
                  ),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  loadData.removeAt(i);
                });
              },
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    print(loadData.length);
    return Scaffold(
      appBar: buildSearchField(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : buildSearchResult(),
    );
  }
}
