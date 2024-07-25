import 'package:flutter/material.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/cross_word_puzzle.dart';
import 'package:kids_lms_project/presentation/screen/drag_and_drop_game.dart';
import 'package:kids_lms_project/presentation/screen/drag_n_drop_screen.dart';
import 'package:kids_lms_project/presentation/screen/top3_screen.dart';
import 'package:kids_lms_project/presentation/screen/wordGame2.dart';

import '../../constants/strings.dart';
import '../widgets/games_list.dart';
import '../widgets/main_button.dart';

class gameslist_properties {
  // Function function;
  int id;
  String name;
  String image;
  // String routename;
  gameslist_properties({
    // required this.function,
    required this.id,
    required this.name,
    required this.image,
    // required this.routename,
  });
}

class GamesListScreen extends StatelessWidget {
  int levelID;
  GamesListScreen({
    Key? key,
    required this.levelID,
  }) : super(key: key);
  final List<gameslist_properties> games = [
    gameslist_properties(
      id: 1,
      name: "Word Search ",
      image: "assets/images/word.png",
      // routename: path_screen,
      // function: (BuildContext context, int levelID_) {},
    ),
    gameslist_properties(
      id: 2,
      name: "second ",
      image: "assets/images/word.png",
      // routename: path_screen,
      // function: (BuildContext context, int levelID_) {},
    ),
    gameslist_properties(
      id: 3,
      name: "Drag & Drop ",
      image: "assets/images/drag.png",
      // routename: drag_and_drop,
      // function: (BuildContext context, int levelID_) {},
    ),
    gameslist_properties(
      id: 4,
      name: " CrossWord puzzle",
      image: "assets/images/cross.png",
      // routename: word_search_game,
      // function: (BuildContext context, int levelID_) {},
    ),
  ];
  Widget topIcon(double top, double left, Function function, String image) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: InkWell(
        onTap: () => function(),
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              image,
            ),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 1600,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/landscape.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                topIcon(50, 30, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => top3_screen(
                                levelId: levelID,
                              )));
                }, "assets/images/top3.png"),
                const Padding(
                  padding: EdgeInsets.only(top: 95, left: 5),
                  child: Text(
                    "View TOP3 in this LEVEL !",
                    style: TextStyle(color: MyAppColors.purple),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180, left: 10),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 170,
                        child: GamsList(
                            function: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WordGame2(
                                      level_id: levelID,
                                    )));},
                            image: "assets/images/word.png",
                            text: "Word Search",
                            fontsize: 16),
                      ),
                      SizedBox(
                        height: 250,
                        width: 170,
                        child: GamsList(
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DragNDropScreen(

                                            GameID: 3, LevelID: levelID,
                                          )));
                            },
                            image: "assets/images/drag.png",
                            text: "Drag & Drop",
                            fontsize: 16),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 170,
                        child: GamsList(
                            function: () {

                            },
                            image: "assets/images/word.png",
                            text: "Word Search",
                            fontsize: 16),
                      ),
                      SizedBox(
                        height: 250,
                        width: 170,
                        child: GamsList(
                            function: () {},
                            image: "assets/images/cross.png",
                            text: "Drag & Drop",
                            fontsize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
