import 'package:flutter/material.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/top3_all_levels_names.dart';
import 'package:kids_lms_project/presentation/widgets/card_list.dart';

import '../../constants/strings.dart';
import '../widgets/buttons_decoration.dart';

class top3_all_screen extends StatelessWidget {
  String index1 = "TOP 1";
  String index2 = "TOP 2";
  String index3 = "TOP 3";

  top3_all_screen({
    Key? key,
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
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 30),
              child: buttons_dec(
                  text: "TOP 3 IN THE WHOLE COURSE",
                  textColor: MyAppColors.darkBlue,
                  fontsize_: 18,
                  height_: 15,
                  width_: double.infinity),
            ),
            const SizedBox(
              height: 80,
            ),
            card_list(
              margin: 20,
              routeName: top3_list,
              text: index1,
              subtilte: "heros who got TOP1 Heighest score",
              image: "assets/images/gold.png",
              color: MyAppColors.purple,
              fontsize: 18,
              color2: MyAppColors.darkGray,
              fontsize2: 14,
              function: () {
                print("alll");
                print(index1);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => top3_all_list_screen(
                              indexID: index1,
                            )));
              },
            ),
            card_list(
              margin: 20,
              routeName: top3_list,
              text: index2,
              subtilte: "second place",
              image: "assets/images/silver.png",
              color: MyAppColors.darkyellow,
              fontsize: 18,
              color2: MyAppColors.darkGray,
              fontsize2: 14,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => top3_all_list_screen(
                              indexID: index2,
                            )));
              },
            ),
            card_list(
              margin: 20,
              routeName: top3_list,
              text: index3,
              subtilte: "Third place",
              image: "assets/images/bronze.png",
              color: MyAppColors.darkBlue,
              fontsize: 18,
              color2: MyAppColors.darkGray,
              fontsize2: 14,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => top3_all_list_screen(
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
