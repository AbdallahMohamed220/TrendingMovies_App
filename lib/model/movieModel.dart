class MovieModel {
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

  MovieModel(
      {this.id,
      this.title,
      this.overview,
      this.voteAverage,
      this.movieImage,
      this.releaseDate,
      this.runtime,
      this.genre,
      this.director,
      this.language,
      this.mediaType,
      this.actors});
}
