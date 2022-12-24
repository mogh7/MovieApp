import 'package:flutter/material.dart';
import 'package:move_app/class/storge.dart';
import 'package:move_app/screens/homePage.dart';

// ignore: must_be_immutable
class CardInfo extends StatefulWidget {
  double width;
  String File_path;
  bool isCastCard;
  int id;
  Function() onTap;
  double height;
  String vote;
  Color? color;

  CardInfo(
      {Key? key,
      required this.width,
      required this.File_path,
      required this.vote,
      required this.onTap,
      required this.id,
      required this.height,
      this.color = Colors.blue,
      required this.isCastCard})
      : super(key: key);

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  @override
  Widget build(BuildContext context) {
    bool isLike =
        HomePage.likeList.any((element) => element['MovieId'] == widget.id);
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            child: widget.File_path == 'null'
                ? Icon(
                    Icons.hide_image_outlined,
                    size: 50,
                  )
                : Image.network(
                    "https://image.tmdb.org/t/p/original" + widget.File_path,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
            clipBehavior: Clip.antiAlias,
            width: widget.width * .4,
            height: widget.height - 50,
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
                colors: [widget.color!, Colors.black.withOpacity(1)],
                focal: Alignment.center,
                radius: 3,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: widget.isCastCard
                ? Center()
                : InkWell(
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
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 50,
            child: widget.isCastCard
                ? Center()
                : Container(
                    height: 50,
                    width: 50,
                    child: Center(
                        child: Text(
                            double.parse(widget.vote).toStringAsFixed(1) +
                                '/10')),
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
                        colors: [widget.color!, Colors.black.withOpacity(1)],
                        focal: Alignment.center,
                        radius: 3,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  reBuildUI() {
    setState(() {});
  }
}
