import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:move_app/class/movie.dart';
// ignore: unused_import
import 'package:move_app/class/storge.dart';
import 'package:move_app/providers/api_get.dart';
import 'package:move_app/screens/favoritePage.dart';
import 'package:move_app/screens/homePage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'Widget/genresList.dart';

void main() {
  execute(InternetConnectionChecker());
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static late Database db;
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
      routes: {
        "/home": (context) => HomePage(),
        "/favorite": (context) => const FavoritePage(),
      },
      home: AnimatedSplashScreen(
        nextScreen: HomePage(),
        splash: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 19, 97, 99).withOpacity(.4),
                blurRadius: 50,
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.asset("assets/movie_splash1.json"),
              ),
              Text("Movie App",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
            ],
          ),
        ),
        backgroundColor: ThemeData.dark().primaryColor,
        splashIconSize: 200,
        duration: 5000,
      ),
    );
  }
}
