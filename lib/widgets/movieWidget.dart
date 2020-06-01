import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/screens/movieDetails.dart';

class MovieWidget extends StatelessWidget {
  final String id;
  final String title;
  final String overview;
  final String voteAverage;
  final String releaseDate;
  final String movieImage;
  final String runtime;
  final String genre;
  final String director;
  final String language;
  final String mediaType;
  final String actors;

  MovieWidget({
    this.id,
    this.title,
    this.movieImage,
    this.releaseDate,
    this.voteAverage,
    this.overview,
    this.runtime,
    this.genre,
    this.director,
    this.language,
    this.mediaType,
    this.actors,
  });

  void selectMovie(BuildContext context) {
    Navigator.of(context).pushNamed(
      MovieDetails.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMovie(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 160,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(movieImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 160,
                width: 150,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 5, right: 4, bottom: 5),
                      child: AutoSizeText(
                        title.length > 20 ? title.substring(0, 20) : title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxFontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'MediaType : $mediaType',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 8),
                      width: 190,
                      height: 100,
                      child: AutoSizeText(
                        overview.length > 150
                            ? overview.substring(0, 145)
                            : overview,
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        maxLines: 4,
                        minFontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8, left: 5),
                child: CircleAvatar(
                  child: Text(
                    voteAverage.toString(),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
