

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_bloc.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_event.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_state.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/data/repository/pdf_lessons.dart';
import 'package:kids_lms_project/presentation/screen/pdf_screen.dart';
import 'package:kids_lms_project/presentation/widgets/container_decoration.dart';

class lessons_screen extends StatelessWidget {
  int levelId;
  // final Datum datum;

  lessons_screen({super.key, required this.levelId});
  Widget imageContainer(String image, double height, double width) {
    return Container(
      margin: EdgeInsets.all(8),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          image: DecorationImage(image: AssetImage(image))),
    );
  }

  Widget text_widget(String text, double size, Color color) => Text(text,
      style: TextStyle(
        fontSize: size,
        color: color,
      ));

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as course_path;
    print("idddddddddddddddin lessssss");
    print(levelId);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PDFLessonsBloc>(
            create: (BuildContext context) =>
                PDFLessonsBloc(PDFLessonsRepository(LevelID: levelId)))
      ],
      child: Scaffold(
          body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                MyAppColors.lightBlue,
                MyAppColors.blue,
                MyAppColors.lightBlue
              ])),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text_widget("Lesson", 40, MyAppColors.darkBlue)
                        ],
                      ),
                    ),
                    SizedBox(height: 70),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: BlocProvider(
                              create: (context) => PDFLessonsBloc(
                                  PDFLessonsRepository(LevelID: levelId))
                                ..add(LoadPdfLessonsEvent()),
                              child:
                                  BlocBuilder<PDFLessonsBloc, PDFLessonsState>(
                                builder: (context, state) {
                                  if (state is PDFLessonsLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is PDFLessonsErrorState) {
                                    print("----------------------staate" +
                                        state.toString());
                                    return const Center(child: Text("Error"));
                                  }
                                  if (state is PDFLessonsLoadedState) {
                                    return ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            PDFReader(
                                                              levelID: levelId,
                                                            )));

                                                print(levelId);
                                              },
                                              child: container_decoration_(
                                                border_radius_val: 30,
                                                container_height: 150,
                                                container_width: 400,
                                                container_color:
                                                    MyAppColors.lightBlue,
                                                color_1:
                                                    MyAppColors.verylightBlue,
                                                color_2: MyAppColors.blue,
                                                color_3: MyAppColors.darkBlue,
                                                color_4: MyAppColors.ligtyellow,
                                              ),
                                            ),
                                          ),
                                          // ListTile(
                                          //     leading: Image.asset(
                                          //   "assets/images/book3.png",
                                          //   fit: BoxFit.cover,
                                          //   width: 80,
                                          //   height: 80,
                                          // ))

                                          Row(
                                            children: [
                                              imageContainer(
                                                  "assets/images/earth.png",
                                                  150,
                                                  100),
                                              Column(
                                                children: [
                                                  text_widget(
                                                      state.pdflist[index].name,
                                                      25,
                                                      MyAppColors.lightBlack),
                                                  text_widget(
                                                      state.pdflist[index]
                                                          .description,
                                                      16,
                                                      MyAppColors.darkGray),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          )),
                    ))
                  ]))),
    );
  }
}
