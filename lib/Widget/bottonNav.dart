import 'package:flutter/material.dart';

class BottomNavBarFb3 extends StatelessWidget {
  BottomNavBarFb3({Key? key}) : super(key: key);

  final primaryColor = const Color(0xff4338CA3f97de);
  static bool isFavorite = false;
  static bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ThemeData.dark().cardColor,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconBottomBar(
                text: "favorite",
                icon: Icons.favorite,
                selected: isFavorite,
                onPressed: () {
                  if (!isFavorite) {
                    isFavorite = true;
                    isHome = false;
                    Navigator.pushReplacementNamed(context, '/favorite');
                  }
                },
              ),
              IconBottomBar(
                text: "/home",
                icon: Icons.home,
                selected: isHome,
                onPressed: () {
                  if (!isHome) {
                    isFavorite = false;
                    isHome = true;
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? BottomNavBarFb3().primaryColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
