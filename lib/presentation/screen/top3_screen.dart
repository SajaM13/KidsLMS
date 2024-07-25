import 'package:flutter/material.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/top3_all_levels_names.dart';
import 'package:kids_lms_project/presentation/screen/top3_levels_names.dart';
import 'package:kids_lms_project/presentation/widgets/card_list.dart';

import '../../constants/strings.dart';

class top3_screen extends StatelessWidget {
  int levelId;
  String index1 = "TOP 1";
  String index2 = "TOP 2";
  String index3 = "TOP 3";

  top3_screen({
    Key? key,
    required this.levelId,
  }) : super(key: key);
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/top3_2.png",
          ),
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            card_list(
              margin: 20,
              routeName: top3_list,
              text: index1,
              subtilte: "heros who got points above 90",
              image: "assets/images/gold.png",
              color: MyAppColors.purple,
              fontsize: 18,
              color2: MyAppColors.darkGray,
              fontsize2: 14,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => top3_list_screen(
                              levelID: levelId,
                              indexID: index1,
                            )));
                print("iiiii");
                print(index1);
              },
            ),
            card_list(
              margin: 20,
              routeName: top3_list,
              text: index2,
              subtilte: "heros who got points between 80 & 90",
              image: "assets/images/silver.png",
              color: MyAppColors.darkyellow,
              fontsize: 18,
              color2: MyAppColors.darkGray,
              fontsize2: 14,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => top3_list_screen(
                              levelID: levelId,
                              indexID: index2,
                            )));
              },
            ),
            card_list(
              margin: 20,
              routeName: top3_list,
              text: index3,
              subtilte: "heros who got points above 70",
              image: "assets/images/bronze.png",
              color: MyAppColors.darkBlue,
              fontsize: 18,
              color2: MyAppColors.darkGray,
              fontsize2: 14,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => top3_list_screen(
                              levelID: levelId,
                              indexID: index3,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
