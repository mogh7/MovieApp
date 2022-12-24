import 'package:flutter/material.dart';
import 'package:move_app/Widget/bottonNav.dart';
import 'package:move_app/class/storge.dart';
import 'package:move_app/screens/MovieDetails.dart';
import 'package:move_app/screens/homePage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarFb3(),
      appBar: AppBar(
        title: Text("Like Movie"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .6,
        ),
        itemCount: HomePage.likeList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetails(
                      File_path: HomePage.likeList
                          .map((e) => e['posterPath'])
                          .elementAt(index)
                          .toString(),
                      id: HomePage.likeList
                          .map((e) => e['MovieId'])
                          .elementAt(index),
                    ),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      child: HomePage.likeList
                                  .map((e) => e['posterPath'])
                                  .elementAt(index) ==
                              'null'
                          ? Icon(
                              Icons.hide_image_outlined,
                              size: 50,
                            )
                          : Image.network(
                              "https://image.tmdb.org/t/p/original" +
                                  HomePage.likeList
                                      .map((e) => e['posterPath'])
                                      .elementAt(index)
                                      .toString(),
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeData.dark().backgroundColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            offset: Offset(5, 5),
                            blurRadius: 2,
                            spreadRadius: 0,
                          )
                        ],
                        gradient: RadialGradient(
                          colors: [Colors.red, Colors.black.withOpacity(1)],
                          focal: Alignment.center,
                          radius: 3,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          deleatMovie(HomePage.likeList
                                  .map((e) => e['MovieId'])
                                  .elementAt(index))
                              .then((value) => setState(
                                    () {},
                                  ));
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
