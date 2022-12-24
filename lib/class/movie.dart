class Movie {
  // ignore: non_constant_identifier_names

  List? results;
  Map? MovieDetails;
  List? castsDetails;
  List? genresMovie;

  Movie({this.MovieDetails, this.castsDetails});
  Movie.MostPoplur({this.results});
  Movie.WithGenres({this.genresMovie});

  factory Movie.fromJsonMovieList(Map<String, dynamic> json) {
    return Movie.MostPoplur(results: json['results']);
  }

  factory Movie.gitMovieDetils(Map<String, dynamic> json) {
    return Movie(castsDetails: json['casts']['cast'], MovieDetails: json);
  }

  factory Movie.gitGenresMovie(Map<String, dynamic> json) {
    return Movie.WithGenres(genresMovie: json['results']);
  }
}
