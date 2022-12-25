import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:move_app/Widget/categoryCard.dart';
import 'package:move_app/Widget/bottonNav.dart';
import 'package:move_app/Widget/cardWidget.dart';
import 'package:move_app/Widget/genresList.dart';
import 'package:move_app/Widget/waitAPI.dart';
import 'package:move_app/class/movie.dart';
import 'package:move_app/class/storge.dart';
import 'package:move_app/main.dart';
import 'package:move_app/providers/api_get.dart';
import 'package:move_app/screens/MovieDetails.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  late Object redrawMovie = Object();
  late Object redrawGenarMovie = Object();
  static late List<Map<String, dynamic>> likeList;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Movie> futerMovie;
  late Future<Movie> MovieWithGenre;

  @override
  void initState() {
    super.initState();
    futerMovie = futchMovieList(SplashScreen.url);
    MovieWithGenre = futchMovieWithGenre(SplashScreen.Movie_genre_id);
    openDb();
    readMovieLike();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarFb3(),
      appBar: AppBar(
        title: Text("Movie App"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryCard(
                  category: categoryList.elementAt(0),
                  onPressed: (b) {
                    categoryList.forEach((element) {
                      element.isSelected = false;
                    });
                    setState(() {
                      widget.redrawMovie = Object();
                      SplashScreen.url =
                          "https://api.themoviedb.org/3/movie/now_playing?api_key=6e8bd8ba9562bac423453074f12f8915&language=en-US&page=1";
                      futerMovie = futchMovieList(SplashScreen.url);
                      categoryList.elementAt(0).isSelected = true;
                    });
                  },
                ),
                CategoryCard(
                  category: categoryList.elementAt(1),
                  onPressed: (b) {
                    categoryList.forEach((element) {
                      element.isSelected = false;
                    });
                    setState(() {
                      widget.redrawMovie = Object();
                      execute(InternetConnectionChecker());
                      SplashScreen.url =
                          "https://api.themoviedb.org/3/trending/movie/week?api_key=6e8bd8ba9562bac423453074f12f8915";
                      futerMovie = futchMovieList(SplashScreen.url);
                      categoryList.elementAt(1).isSelected = true;
                    });
                  },
                ),
                CategoryCard(
                  category: categoryList.elementAt(2),
                  onPressed: (b) {
                    categoryList.forEach((element) {
                      element.isSelected = false;
                    });
                    setState(() {
                      widget.redrawMovie = Object();
                      execute(InternetConnectionChecker());
                      SplashScreen.url =
                          "https://api.themoviedb.org/3/movie/popular?api_key=6e8bd8ba9562bac423453074f12f8915&language=en-US&page=1";
                      futerMovie = futchMovieList(SplashScreen.url);
                      categoryList.elementAt(2).isSelected = true;
                    });
                  },
                ),
                CategoryCard(
                  category: categoryList.elementAt(3),
                  onPressed: (b) {
                    categoryList.forEach((element) {
                      element.isSelected = false;
                    });
                    setState(() {
                      widget.redrawMovie = Object();
                      execute(InternetConnectionChecker());
                      SplashScreen.url =
                          "https://api.themoviedb.org/3/movie/upcoming?api_key=6e8bd8ba9562bac423453074f12f8915&language=en-US&page=1";
                      futerMovie = futchMovieList(SplashScreen.url);
                      categoryList.elementAt(3).isSelected = true;
                    });
                  },
                ),
              ],
            ),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(5, 5),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: BottomNavBarFb3().primaryColor.withOpacity(.2)),
            ]),
          ),
          FutureBuilder<Movie>(
            key: ValueKey(widget.redrawMovie),
            future: futerMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CardInfo(
                          color: BottomNavBarFb3().primaryColor,
                          height: MediaQuery.of(context).size.height / 2.6,
                          isCastCard: false,
                          File_path: snapshot.data!.results!
                              .map((e) => e['poster_path'])
                              .elementAt(index)
                              .toString(),
                          vote: snapshot.data!.results!
                              .map((e) => e['vote_average'])
                              .elementAt(index)
                              .toString(),
                          width: MediaQuery.of(context).size.width,
                          id: snapshot.data!.results!
                              .map((e) => e['id'])
                              .elementAt(index),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                    File_path: snapshot.data!.results!
                                        .map((e) => e['poster_path'])
                                        .elementAt(index)
                                        .toString(),
                                    id: snapshot.data!.results!
                                        .map((e) => e['id'])
                                        .elementAt(index)),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return waitAPI(
                    checkWidget: waitAPI.contect
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.signal_wifi_connected_no_internet_4,
                                size: 30,
                              ),
                              Text("Connected to the internet"),
                            ],
                          ),
                    height: MediaQuery.of(context).size.height / 2.6,
                    color: BottomNavBarFb3().primaryColor);
              }
              return waitAPI(
                checkWidget: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
                color: BottomNavBarFb3().primaryColor,
                height: MediaQuery.of(context).size.height / 2.6,
              );
            },
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Movie :",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: const Offset(5, 5),
                        blurRadius: 50,
                        spreadRadius: 0,
                        color: Colors.deepPurpleAccent.withOpacity(.3)),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        color: Colors.deepPurpleAccent.withOpacity(.3),
                        blurRadius: 50,
                      )
                    ]),
                    child: DropdownButton<String>(
                      onChanged: (String? value) {
                        SplashScreen.Movie_genre_id = genre_Movie_id_list
                            .elementAt(genreMovielist.indexOf(value!));
                        setState(() {
                          widget.redrawGenarMovie = Object();
                          SplashScreen.dropDownMovie = value;
                          MovieWithGenre =
                              futchMovieWithGenre(SplashScreen.Movie_genre_id);
                        });
                      },
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      value: SplashScreen.dropDownMovie,
                      items: genreMovielist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<Movie>(
            key: ValueKey(widget.redrawGenarMovie),
            future: MovieWithGenre,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2.6,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.genresMovie!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CardInfo(
                          color: Colors.deepPurple,
                          id: snapshot.data!.genresMovie!
                              .map((e) => e['id'])
                              .elementAt(index),
                          isCastCard: false,
                          File_path: snapshot.data!.genresMovie!
                              .map((e) => e['poster_path'])
                              .elementAt(index)
                              .toString(),
                          width: MediaQuery.of(context).size.width,
                          vote: snapshot.data!.genresMovie!
                              .map((e) => e['vote_average'])
                              .elementAt(index)
                              .toString(),
                          height: MediaQuery.of(context).size.height / 2.6,
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                  File_path: snapshot.data!.genresMovie!
                                      .map((e) => e['poster_path'])
                                      .elementAt(index)
                                      .toString(),
                                  id: snapshot.data!.genresMovie!
                                      .map((e) => e['id'])
                                      .elementAt(index)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return waitAPI(
                    checkWidget: waitAPI.contect
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.signal_wifi_connected_no_internet_4,
                                size: 30,
                              ),
                              Text("Connected to the internet"),
                            ],
                          ),
                    height: MediaQuery.of(context).size.height / 2.6,
                    color: Colors.deepPurple);
              }

              return waitAPI(
                checkWidget: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
                color: Colors.deepPurple,
                height: MediaQuery.of(context).size.height / 2.6,
              );
            },
          ),
        ],
      ),
    );
  }
}
