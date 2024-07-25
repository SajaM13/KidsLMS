import 'package:flutter/material.dart';

import 'package:kids_lms_project/constants/colors.dart';

// ignore: must_be_immutable
class LevelDesign_ extends StatelessWidget {
  String image;
  double cont_width;
  double cont_height;
  String text;
  Color textColor;
  double fontsize;
  double top;
  double left;
  // Function OnTap_function;
  // Function OnLongTap_function;
  LevelDesign_({
    Key? key,
    required this.image,
    required this.cont_width,
    required this.cont_height,
    required this.text,
    required this.textColor,
    required this.fontsize,
    required this.top,
    required this.left,
  }) : super(key: key);

  Widget level_design() {
    return Container(
      height: cont_height,
      width: cont_width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.contain),
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }

/*   Image.asset(
            'assets/images/gameMap1.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),*/
  @override
  Widget build(BuildContext context) {
    return level_design();
  }
}
