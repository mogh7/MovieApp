import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// ignore: unused_import
import 'package:move_app/class/storge.dart';
import 'package:move_app/providers/api_get.dart';
import 'package:move_app/screens/favoritePage.dart';
import 'package:move_app/screens/homePage.dart';

import 'Widget/genresList.dart';

void main() {
  execute(InternetConnectionChecker());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  static String url =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=6e8bd8ba9562bac423453074f12f8915&language=en-US&page=1";

  static String dropDownMovie = genreMovielist.first;
  static int Movie_genre_id = 16;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/favorite": (context) => const FavoritePage(),
      },
    );
  }
}
