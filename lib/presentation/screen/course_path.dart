import 'package:flutter/material.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/presentation/widgets/levels_map.dart';
import '../../app_router.dart';
import '../widgets/card_list.dart';

// ignore: camel_case_types
class course_path extends StatelessWidget {
  List<double> TopValues = [
    20,

    // 1470,
    // 1370,
    // 1240,
    // 1070,
    // 935,
    // 759,
    // 660,
    // 570,
    // 430,
    // 340,
    // 270,
    // 35,
  ];
  List<double> RightValues = [
    // 200.0,
    // 25.0,
    // 215.0,
    // 170.0,
    // 8,
    // 150.0,
    // 200.0,
    20.0,
    220,
    35,
    170,
    70
  ];
  late final AppRouter approuter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/backMap.jpg",
              ),
            )),
          ),
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) => Stack(
              children: [
                Padding(
                  padding: index % 2 == 0
                      ? EdgeInsets.only(top: 30, left: 75)
                      : EdgeInsets.only(top: 30, left: 170),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, levels_content),
                    onLongPress: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30))),
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/top3_2.png",
                                ),
                              )),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                    itemBuilder: (context, index) => card_list(
                                        margin: 8,
                                        routeName: "",
                                        text: "Student name",
                                        subtilte: "student nickname",
                                        image: "assets/images/top3.png",
                                        color: MyAppColors.purple,
                                        fontsize: 18,
                                        color2: MyAppColors.darkGray,
                                        fontsize2: 14),
                                  ))
                                ],
                              ),
                            );
                          });
                    },
                    child: LevelDesign_(
                      image: "assets/images/active_B.png",
                      cont_width: 120,
                      cont_height: 120,
                      text: "1",
                      textColor: MyAppColors.yellow2,
                      fontsize: 20,
                      left: 63,
                      top: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Column(
          //   children: [
          //     Expanded(child: ListView.builder(
          //       itemBuilder: (BuildContext context, int index) {
          //         return Container();
          //       },
          //     ))
          //   ],
          // ),
          /* ListView.builder(
              itemCount: 1,
              reverse: true,
              itemBuilder: (BuildContext context, int index) => Stack(
                children: [
                  Container(
                    height: 1600,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/gameMap.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[0],
                    right: RightValues[0],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/activelevel.png",
                        cont_width: 100,
                        cont_height: 100,
                        text: "1",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 63,
                        top: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[1],
                    right: RightValues[1],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "2",
                        textColor: MyAppColors.purple,
                        fontsize: 20, left: 78, top: 25,
                        // right_val: RightValues[0],
                        // top_val: TopValues[0],
                        // OnLongTap_function: , OnTap_function: ,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[2],
                    right: RightValues[2],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "3",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 78,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[3],
                    right: RightValues[3],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "4",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 78,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[4],
                    right: RightValues[4],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "5",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 78,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[5],
                    right: RightValues[5],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/quiz.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "",
                        textColor: MyAppColors.darkGray,
                        fontsize: 20,
                        left: 63,
                        top: 12,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[6],
                    right: RightValues[6],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "7",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 78,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[7],
                    right: RightValues[7],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "8",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 78,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[8],
                    right: RightValues[8],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "9",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 78,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[9],
                    right: RightValues[9],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/unactbook.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "10",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 72,
                        top: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[10],
                    right: RightValues[10],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/cup.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "11",
                        textColor: MyAppColors.purple,
                        fontsize: 20,
                        left: 50,
                        top: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    top: TopValues[11],
                    right: RightValues[11],
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, levels_content),
                      onLongPress: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/top3_2.png",
                                  ),
                                )),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: ListView.builder(
                                      itemBuilder: (context, index) => card_list(
                                          margin: 8,
                                          routeName: "",
                                          text: "Student name",
                                          subtilte: "student nickname",
                                          image: "assets/images/top3.png",
                                          color: MyAppColors.purple,
                                          fontsize: 18,
                                          color2: MyAppColors.darkGray,
                                          fontsize2: 14),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },
                      child: LevelDesign_(
                        image: "assets/images/quiz.png",
                        cont_width: 120,
                        cont_height: 120,
                        text: "",
                        textColor: MyAppColors.darkGray,
                        fontsize: 20,
                        left: 63,
                        top: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 10),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, top3),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/top3.png",
                  ),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 10),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                width: 60,
                child: Icon(
                  Icons.menu_rounded,
                  size: 50,
                  color: MyAppColors.darkyellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
