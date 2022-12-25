import 'package:flutter/material.dart';
import 'package:move_app/Widget/bottonNav.dart';
import 'package:move_app/Widget/cardWidget.dart';
import 'package:move_app/Widget/waitAPI.dart';
import 'package:move_app/class/movie.dart';
import 'package:move_app/class/storge.dart';
import 'package:move_app/providers/api_get.dart';
import 'package:move_app/screens/homePage.dart';

// ignore: must_be_immutable
class MovieDetails extends StatefulWidget {
  String File_path;

  int id;

  MovieDetails({Key? key, required this.File_path, required this.id})
      : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState(Movie_id: id);
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<Movie> futureMovieDetils;
  late int Movie_id;
  late bool isLike;
  _MovieDetailsState({required this.Movie_id});

  @override
  void initState() {
    super.initState();
    futureMovieDetils = futchMovieDetils(Movie_id);
  }

  String over = "";

  @override
  Widget build(BuildContext context) {
    isLike =
        HomePage.likeList.any((element) => element['MovieId'] == widget.id);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.local_movies_outlined,
                          color: Colors.grey,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 40,
                      )
                    ],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(165)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/original" +
                              widget.File_path),
                    ),
                  ),
                ),
                FutureBuilder<Movie>(
                  future: futureMovieDetils,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List list = snapshot.data!.MovieDetails!['genres'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data!.MovieDetails!['original_title']
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.reviews,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  snapshot.data!.MovieDetails!['vote_count']
                                          .toString() +
                                      ' reviews',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  double.parse(snapshot.data!
                                              .MovieDetails!['vote_average']
                                              .toString())
                                          .toStringAsFixed(2) +
                                      '/10',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Center(
                                  child: Text(
                                    'Genres',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            list
                                                .map((e) => e['name'])
                                                .elementAt(index)
                                                .toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: RadialGradient(
                                            colors: [
                                              BottomNavBarFb3()
                                                  .primaryColor
                                                  .withOpacity(.7),
                                              Colors.black.withOpacity(1)
                                            ],
                                            focal: Alignment.bottomRight,
                                            radius: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.3),
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Overview',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data!.MovieDetails!['overview']
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Casts',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 270,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.castsDetails!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CardInfo(
                                          color: Color(0xff0073B3),
                                          vote: '0',
                                          height: 270,
                                          id: Movie_id,
                                          isCastCard: true,
                                          File_path: snapshot
                                              .data!.castsDetails!
                                              .map((e) => e['profile_path'])
                                              .elementAt(index)
                                              .toString(),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data!.castsDetails!
                                            .map((e) => e['name'])
                                            .elementAt(index)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return waitAPI.contect
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
                            );
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  },
                ),
              ],
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => BottomNavBarFb3.isHome
                          ? Navigator.pushReplacementNamed(context, '/home')
                          : Navigator.pushReplacementNamed(
                              context, '/favorite'),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          if (isLike) {
                            deleatMovie(widget.id).then((value) => reBuildUI());
                          } else {
                            insertMovieLike(MovieLike(
                                    MovieId: widget.id,
                                    posterPath: widget.File_path))
                                .then((value) => reBuildUI());
                          }
                        },
                        child: Icon(
                          isLike ? Icons.favorite : Icons.favorite_border,
                          color: isLike ? Colors.red : null,
                          size: 30,
                        ),
                        // child: FutureBuilder(
                        //   future: readMovieLike(),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  reBuildUI() {
    setState(() {});
  }
}
