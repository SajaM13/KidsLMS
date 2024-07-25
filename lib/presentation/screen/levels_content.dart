

import 'package:flutter/material.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/games_list.dart';
import 'package:kids_lms_project/presentation/screen/lessons_screen.dart';
import 'package:kids_lms_project/presentation/widgets/container_decoration.dart';

class level_contents extends StatelessWidget {
  int levelid;
  level_contents({
    Key? key,
    required this.levelid,
  }) : super(key: key);
  Widget image_(String image, double height, double width) {
    return Image.asset(
      image,
      height: height,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.lightBlue.withOpacity(0.8),
      body: Column(
        children: [
          Stack(children: [
            // SizedBox(hei),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 130, 16, 8),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => lessons_screen(
                              levelId: levelid,
                            ))),
                child: container_decoration_(
                  border_radius_val: 20,
                  container_height: 200,
                  container_width: 400,
                  container_color: MyAppColors.lightBlue,
                  color_1: MyAppColors.verylightBlue,
                  color_2: MyAppColors.blue,
                  color_3: MyAppColors.darkBlue,
                  color_4: MyAppColors.ligtyellow,
                ),
              ),
            ),
            Positioned(
                top: 20,
                right: 130,
                child: image_('assets/images/rocket.png', 250, 250)),
            Positioned(
                top: 210,
                right: 10,
                child: image_('assets/images/earth.png', 170, 170)),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 400, 16, 8),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => GamesListScreen(
                              levelID: levelid,
                            ))),
                child: container_decoration_(
                  border_radius_val: 20,
                  container_height: 200,
                  container_width: 400,
                  container_color: MyAppColors.lightPink,
                  color_1: MyAppColors.veryLightPink,
                  color_2: MyAppColors.pink,
                  color_3: MyAppColors.lightPink,
                  color_4: MyAppColors.darkPink,
                ),
              ),
            ),
            Positioned(
                top: 300,
                right: 70,
                child: image_('assets/images/cubes.png', 250, 250)),
            Positioned(
                top: 490,
                right: 10,
                child: image_('assets/images/controller.png', 150, 150)),
          ])
        ],
      ),
    );
  }
}
