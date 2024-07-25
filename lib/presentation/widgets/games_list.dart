// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/widgets/main_button.dart';

class GamsList extends StatelessWidget {
  Function function;
  String image;
  String text;
  // String routeName;
  double fontsize;

  GamsList({
    Key? key,
    required this.function,
    required this.image,
    required this.text,
    // required this.routeName,
    required this.fontsize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            child: Image.asset(image),
          ),
          main_button(
            height_: 40,
            width_: 10,
            margin_: 8,
            color_1: MyAppColors.ligtyellow,
            color_2: MyAppColors.yellow2,
            textColor: MyAppColors.darkGray,
            text: text,
            // routeName: routeName,
            function: function,
          )
        ],
      ),
    );
  }
}
