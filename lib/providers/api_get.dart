import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:move_app/Widget/waitAPI.dart';
import 'package:move_app/class/movie.dart';

String APIKey = "6e8bd8ba9562bac423453074f12f8915";

Future<Movie> futchMovieList(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return Movie.fromJsonMovieList(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception('Failed to load futchMovieList');
  }
}

Future<Movie> futchMovieWithGenre(int id_genra) async {
  final response = await http.get(
      "https://api.themoviedb.org/3/discover/movie?api_key=" +
          APIKey +
          "&language=en&sort_by=popularity.desc&with_genres=" +
          id_genra.toString() +
          "&page=1&&with_watch_monetization_types=flatrate");

  if (response.statusCode == 200) {
    return Movie.gitGenresMovie(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load futchMovieWithGenre');
  }
}

Future<Movie> futchMovieDetils(int Movie_id) async {
  final response = await http.get("https://api.themoviedb.org/3/movie/" +
      Movie_id.toString() +
      "?api_key=" +
      APIKey +
      "&language=en&append_to_response=casts");

  if (response.statusCode == 200) {
    return Movie.gitMovieDetils(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load futchMovieWithCast');
  }
}

Future<void> execute(
  InternetConnectionChecker internetConnectionChecker,
) async {
  // Simple check to see if we have Internet
  // ignore: avoid_print

  final bool isConnected = await InternetConnectionChecker().hasConnection;
  waitAPI.contect = isConnected;

  // // ignore: avoid_print
  // print(
  //   isConnected.toString(),
  // );
}
