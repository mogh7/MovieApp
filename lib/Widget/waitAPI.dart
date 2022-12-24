import 'package:flutter/material.dart';

class waitAPI extends StatelessWidget {
  double height;

  Color color;

  static bool contect = true;

  Widget checkWidget;

  waitAPI(
      {Key? key,
      required this.height,
      required this.color,
      required this.checkWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                    width: (MediaQuery.of(context).size.width * .4),
                    height: height - 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          offset: Offset(5, 5),
                          blurRadius: 5,
                          spreadRadius: 0,
                        )
                      ],
                      gradient: RadialGradient(
                        colors: [color, Colors.black.withOpacity(1)],
                        focal: Alignment.center,
                        radius: 3,
                      ),
                    ),
                    child: checkWidget),
                Positioned(
                  bottom: 0,
                  right: 50,
                  child: Container(
                    height: 50,
                    width: 50,
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
                        colors: [color, Colors.black.withOpacity(1)],
                        focal: Alignment.center,
                        radius: 3,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
