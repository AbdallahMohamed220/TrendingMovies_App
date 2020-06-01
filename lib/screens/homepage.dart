import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/movie.dart';
import 'package:movies/screens/search.dart';
import 'package:movies/widgets/movieWidget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _loadedInitData = true;
  var _isloading = true;
  PageController pageController;
  int pageIndex = 0;

  Future<void> _getData() async {
    await Provider.of<Movie>(context).fetchAndSetData();
  }

  @override
  void didChangeDependencies() async {
    pageController = PageController();
    if (_loadedInitData) {
      setState(() {
        _isloading = true;
      });

      _getData().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var productsitems = Provider.of<Movie>(context).loadData;
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Trending',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 4,
              centerTitle: true,
            ),
            body: _isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => MovieWidget(
                        id: productsitems[i].id,
                        movieImage: productsitems[i].movieImage,
                        title: productsitems[i].title,
                        overview: productsitems[i].overview,
                        releaseDate: productsitems[i].releaseDate,
                        voteAverage: productsitems[i].voteAverage,
                        director: productsitems[i].director,
                        genre: productsitems[i].genre,
                        language: productsitems[i].language,
                        runtime: productsitems[i].runtime,
                        actors: productsitems[i].actors,
                        mediaType: productsitems[i].mediaType,
                      ),
                      itemCount: productsitems.length,
                    ),
                  ),
          ),
          Search(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
        ],
      ),
    );
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(
    //         'Movie',
    //         style: TextStyle(color: Colors.black),
    //       ),
    //       backgroundColor: Colors.white,
    //       elevation: 4,
    //       actions: <Widget>[
    //         IconButton(
    //           icon: Icon(
    //             Icons.search,
    //             color: Colors.black,
    //           ),
    //           onPressed: () {},
    //         )
    //       ],
    //     ),
    //     backgroundColor: Colors.grey[300],
    //     body: _isloading
    //         ? Center(
    //             child: CircularProgressIndicator(),
    //           )
    //         : ListView.builder(
    //             itemBuilder: (ctx, i) => MovieWidget(
    //               id: productsitems[i].id,
    //               movieImage: productsitems[i].movieImage,
    //               title: productsitems[i].title,
    //               overview: productsitems[i].overview,
    //               releaseDate: productsitems[i].releaseDate,
    //               voteAverage: productsitems[i].voteAverage,
    //               director: productsitems[i].director,
    //               genre: productsitems[i].genre,
    //               language: productsitems[i].language,
    //               runtime: productsitems[i].runtime,
    //             ),
    //             itemCount: productsitems.length,
    //           ));
  }
}
