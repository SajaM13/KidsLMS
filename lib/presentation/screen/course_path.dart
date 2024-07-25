

// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/app_router.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_bloc.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_event.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_state.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/data/models/path_model.dart';
import 'package:kids_lms_project/data/repository/path_repo.dart';
import 'package:kids_lms_project/presentation/screen/drawer.dart';
import 'package:kids_lms_project/presentation/screen/levels_content.dart';
import 'package:kids_lms_project/presentation/screen/quiz_screen.dart';
import 'package:kids_lms_project/presentation/screen/top3_all_levels_screen.dart';
import 'package:kids_lms_project/presentation/screen/top3_screen.dart';
import 'package:kids_lms_project/presentation/widgets/card_list.dart';
import 'package:kids_lms_project/presentation/widgets/levels_map.dart';

class course_path extends StatefulWidget {
  int levelId;
  course_path({
    Key? key,
    required this.levelId,
  }) : super(key: key);
  @override
  State<course_path> createState() => _course_pathState();
}

class _course_pathState extends State<course_path> {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoursePathBloc>(
            create: (BuildContext context) =>
                CoursePathBloc(coursePathRepository()))
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/landscape.jpg",
                ),
              )),
            ),
            BlocProvider(
              create: (context) => CoursePathBloc(coursePathRepository())
                ..add(LoadCoursepathEvent()),
              child: BlocBuilder<CoursePathBloc, CoursPathState>(
                builder: (context, state) {
                  if (state is CoursPathLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CoursPathErrorState) {
                    print("----------------------staate" + state.toString());
                    return const Center(child: Text("Error"));
                  }
                  if (state is CoursPathLoadedState) {
                    List<Datum> levels_map = state.coursePathlist;
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: levels_map.length,
                      itemBuilder: (BuildContext context, int index) => Stack(
                        children: [
                          Padding(
                            padding: index % 2 == 0
                                ? EdgeInsets.only(top: 30, left: 75)
                                : EdgeInsets.only(top: 30, left: 170),
                            child: InkWell(
                              onTap: () {
                                if (state.coursePathlist[index].isquiz ==
                                    "false") {
                                  state.coursePathlist[index].isavailable ==
                                      "true"
                                      ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => level_contents(
                                            levelid: levels_map[index]
                                                .levelId,
                                          )))
                                      : null;
                                  print(levels_map[index].levelId);
                                }
                                else {
                                  state.coursePathlist[index].isavailable ==
                                      "true"
                                      ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>QuizScreen(
                                            quizId: levels_map[index]
                                                .levelId,
                                          )))
                                      : null;
                                }
                              },


                              // Navigator.pushNamed(
                              //     context, lessons_content,),
                              // arguments: course_path(
                              //     levelId: levels_map[index].levelId)),
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
                                                    itemCount: levels_map[index]
                                                        .name
                                                        .length,
                                                    itemBuilder:
                                                        (context, indx) {
                                                      return card_list(
                                                        margin: 8,
                                                        routeName: "",
                                                        text: levels_map[index]
                                                            .name[indx]
                                                            .name,
                                                        subtilte:
                                                            levels_map[index]
                                                                .name[indx]
                                                                .nickname,
                                                        image:
                                                            "assets/images/top3.png",
                                                        color:
                                                            MyAppColors.purple,
                                                        fontsize: 18,
                                                        color2: MyAppColors
                                                            .darkGray,
                                                        fontsize2: 14,
                                                        function: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      top3_screen(
                                                                        levelId:
                                                                            levels_map[index].levelId,
                                                                      )));
                                                          print(
                                                              levels_map[index]
                                                                  .levelId);
                                                        },
                                                      );
                                                    }))
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: LevelDesign_(
                                image: levels_map[index].isavailable == "true"
                                    ? "assets/images/active_B.png"
                                    : "assets/images/unactive_B.png",
                                cont_width: 120,
                                cont_height: 120,
                                text: levels_map[index].levelId.toString(),
                                textColor: MyAppColors.yellow2,
                                fontsize: 20,
                                left: 63,
                                top: 12,
                              ),
                            ),
                          ),
                          // index % 2 == 0
                          //     ? CustomPaint(
                          //         size: Size(
                          //             MediaQuery.of(context).size.height, 300),
                          //         painter: MyPainter(),
                          //       )
                          //     : CustomPaint(
                          //         size: Size(
                          //             MediaQuery.of(context).size.height / 0.3,
                          //             300),
                          //         painter: MyPainter_reverse(),
                          //       ),

                          // index % 2 == 0
                          //     ? DashedLine.svgPath(
                          //         'C -40 50 10 55 40 80',
                          //         color: Color.fromARGB(255, 8, 76, 118),
                          //         width: 7,
                          //       )
                          //     : DashedLine.svgPath(
                          //         'C -40 -30 10 55 40 80',
                          //         color: Color.fromARGB(255, 8, 76, 118),
                          //         width: 7,
                          //       )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 10),
              child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => top3_all_screen())),
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
                onTap: () {

                },
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
        drawer:  CustomDrawer(),
      ),

    );
  }
}


