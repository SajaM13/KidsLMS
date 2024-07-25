
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/business_logic/drag_game_bloc/drag_game_bloc.dart';
import 'package:kids_lms_project/business_logic/drag_game_bloc/drag_game_event.dart';
import 'package:kids_lms_project/business_logic/drag_game_bloc/drag_game_state.dart';

import 'package:kids_lms_project/data/models/drag_n_drop_model.dart';
import 'package:kids_lms_project/data/repository/drag_game_repo.dart';
import 'package:kids_lms_project/data/repository/send_game_score_repo.dart';
import 'package:kids_lms_project/presentation/widgets/image_decoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';

import 'drag_game_second.dart';

// ignore: use_key_in_widget_constructors
class DragNDropScreen extends StatefulWidget {
  int LevelID;
  int GameID;
  DragNDropScreen({
    required this.LevelID,
    required this.GameID,
  });
  @override
  // ignore: library_private_types_in_public_api
  _DragNDropScreenState createState() => _DragNDropScreenState();
}

class _DragNDropScreenState extends State<DragNDropScreen> {
  final SendScoreRepository _sendScoreRepository = SendScoreRepository();
  // var player = AudioCache();
  // List listt = [];
  int score = 0;
  int stage_index = 1;
  // bool gameOver = false;
  bool accepting = false;
  // int counter = 0;
  List<dynamic> test_list = [];
  List<dynamic> test_list2 = [];
  bool is_done = false;

  @override
  Widget build(BuildContext context) {















    // if (items.length == 0) gameOver = true;
    return MultiBlocProvider(
      providers: [
        BlocProvider<DragGameBloc>(
            create: (BuildContext context) => DragGameBloc(
                DragGameRepository(LevelID_: widget.LevelID, GameID_: 3)))
      ],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/landscape.jpg",
            ),
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Score: ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: '$score',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
              if (score != 80)
                BlocProvider(
                  create: (context) => DragGameBloc(
                      DragGameRepository(LevelID_: widget.LevelID, GameID_: 3))
                    ..add(LoadCDragGameEvent()),
                  child: BlocBuilder<DragGameBloc, DragGameState>(
                    builder: (context, state) {
                      if (state is DragGameLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is DragGameErrorState) {
                        print(
                            "----------------------staate" + state.toString());
                        return const Center(child: Text("Error"));
                      }
                      if (state is DragGameLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Spacer(),
                                    Column(
                                      children: state.dragGameList[0].index1
                                          .map((item) {
                                        test_list =
                                            state.dragGameList[0].index1;
                                        return Container(
                                          margin: EdgeInsets.all(8),
                                          child: Draggable<Index>(
                                            data: item,
                                            childWhenDragging:
                                                item.type == "true"
                                                    ? CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 50,
                                                        child:
                                                            imageFromBase64String(
                                                                item.value1),
                                                      )
                                                    : Container(),
                                            feedback: item.type == "true"
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    radius: 30,
                                                    child:
                                                        imageFromBase64String(
                                                            item.value1),
                                                  )
                                                : Container(),
                                            child: item.type == "true"
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    radius: 30,
                                                    child:
                                                        imageFromBase64String(
                                                            item.value1),
                                                  )
                                                : Container(),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Spacer(flex: 2),
                                    Column(
                                      children: state.dragGameList[0].index1Copy
                                          .map((item) {
                                        test_list2 =
                                            state.dragGameList[0].index1Copy;
                                        return DragTarget<Index>(
                                          onAccept: (receivedItem) {
                                            // listt = state.dragGameList[0].index1;
                                            print(
                                                "testt item index is = ${item.value2}");
                                            print(
                                                "testt recv index is = ${receivedItem.value2}");

                                            if (item.value2 ==
                                                receivedItem.value2) {
                                              setState(() {
                                                // item.scoreGame += 10;
                                                // score = item.scoreGame;
                                                // counter++;
                                                receivedItem.type = "false";
                                                // item.type == "false";
                                                score += 10;

                                                is_done = true;

                                                // score = item.index1[index].scoreGame;
                                              });

                                              // print(
                                              //     "score = ${score}// anddd anddd ${item.index1[index].scoreGame}");

                                              print("index = ${index}");

                                              // player.play('true.wav');
                                            } else {
                                              setState(() {
                                                // score -= 5;
                                                accepting = false;
                                                // player.play('false.wav');
                                              });
                                            }
                                          },
                                          onWillAccept: (receivedItem) {
                                            setState(() {
                                              accepting = true;
                                            });
                                            return true;
                                          },
                                          onLeave: (receivedItem) {
                                            setState(() {
                                              accepting = false;
                                            });
                                          },
                                          builder: (context, acceptedItems,
                                                  rejectedItems) =>
                                              Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: accepting
                                                        ? Colors.grey[400]
                                                        : Colors.grey[200],
                                                  ),
                                                  alignment: Alignment.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6.5,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  margin: EdgeInsets.all(8),
                                                  child: Text(
                                                    item.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  )),
                                        );
                                      }).toList(),
                                    ),
                                    Spacer(),
                                  ],
                                );
                              }),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              if (score == 80) winnigGame(),
              //   Center(
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             'Game Over',
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .titleLarge!
              //                 .copyWith(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.red),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             result(),
              //             style: Theme.of(context).textTheme.displaySmall,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // if (score == 80)
              //   Container(
              //     height: MediaQuery.of(context).size.width / 10,
              //     decoration: BoxDecoration(
              //         color: Colors.teal,
              //         borderRadius: BorderRadius.circular(8)),
              //     child: TextButton(
              //         onPressed: () {
              //           // setState(() {
              //           //   // initGame();
              //           // });
              //         },
              //         child: Text(
              //           'New Game',
              //           style: TextStyle(color: Colors.white),
              //         )),
              //   )
            ],
          ),
        ),
      ),
    );
  }

  //Functions:

  String result() {
    if (score == 80) {
      // player.play('success.wav');
      return 'Awesome!';
    } else {
      // player.play('tryAgain.wav');
      return 'Play again to get better score';
    }
  }

  Widget winnigGame() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: AlertDialog(
        title: Text(
          'Congratulations!  ',
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold, color: MyAppColors.darkyellow),
        ),
        content: Text(
            ' You have completed this game and your total Score is : $score  ',
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold, color: MyAppColors.green)),
        actions: <Widget>[
          ButtonBar(alignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
              child: Text('Replay',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: MyAppColors.darkBlue)),
              onPressed: () {
                _sendScoreRepository.SendGamescoretoAPI(
                    score, widget.LevelID, widget.GameID);
                print('score + ${score}');
                print('levelID + ${widget.LevelID}');
                print('gameID + ${widget.GameID}');

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('next level !',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: MyAppColors.darkBlue)),
              onPressed: () {
                _sendScoreRepository.SendGamescoretoAPI(
                    score, widget.LevelID, widget.GameID);
                print('score + ${score}');
                print('levelID + ${widget.LevelID}');
                print('gameID + ${widget.GameID}');
                setState(() {
                  score = 80;
                  stage_index = 2;
                });

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DragNDropSecondScreen(
                              LevelID: widget.LevelID,
                              GameID: widget.GameID,
                              gamescore: score,
                            )));
              },
            ),
            TextButton(
              child: Text('Main ',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: MyAppColors.darkBlue)),
              onPressed: () {
                _sendScoreRepository.SendGamescoretoAPI(
                    score, widget.LevelID, widget.GameID);
                print('score + ${score}');
                print('levelID + ${widget.LevelID}');
                print('gameID + ${widget.GameID}');
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ]),
        ],
      ),
    );
  }
}
