// // import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kids_lms_project/business_logic/drag_and_drop_bloc/drag_n_drop_event.dart';
// import 'package:kids_lms_project/business_logic/drag_and_drop_bloc/drag_n_drop_state.dart';
// import 'package:kids_lms_project/constants/colors.dart';
// import 'package:kids_lms_project/data/models/drag_and_drop_model.dart';
// import 'package:kids_lms_project/data/repository/drag_and_drop_repo.dart';
// import 'package:kids_lms_project/presentation/widgets/image_decoding.dart';

// import '../../business_logic/drag_and_drop_bloc/drag_n_drop_bloc.dart';

// class ItemModel {
//   final String name;
//   final String img;
//   final String value;
//   bool accepting;
//   ItemModel(
//       {required this.name,
//       required this.value,
//       required this.img,
//       this.accepting = false});
// }

// // audioplayers: ^0.19.0 in yaml

// class drag_and_drop_screen extends StatefulWidget {
//   int LevelId;
//   int GameID;
//   drag_and_drop_screen({
//     Key? key,
//     required this.LevelId,
//     required this.GameID,
//   }) : super(key: key);
//   @override
//   _DragAndDropScreenState createState() => _DragAndDropScreenState();
// }

// class _DragAndDropScreenState extends State<drag_and_drop_screen> {
//   // var player = AudioCache();
//   List<ItemModel> items = [
//     ItemModel(value: 'top', name: 'Top3', img: 'assets/images/top3.png'),
//     ItemModel(value: 'rocket', name: 'Rocket', img: 'assets/images/rocket.png'),
//     ItemModel(value: 'game', name: 'Game', img: 'assets/images/game.png'),
//     ItemModel(value: 'books', name: 'Books', img: 'assets/images/helper3.png'),
//     ItemModel(value: 'book', name: 'Book', img: 'assets/images/book.png'),
//     ItemModel(value: 'gold', name: 'Gold', img: 'assets/images/gold.png'),
//     ItemModel(value: 'silver', name: 'Silver', img: 'assets/images/silver.png'),
//     ItemModel(value: 'bronze', name: 'Bronze', img: 'assets/images/bronze.png'),
//     // ItemModel(value: 'fox', name: 'Fox', img: 'assets/images/earth.png'),
//     // ItemModel(value: 'cow', name: 'Cow', img: 'assets/images/cubes.png'),
//   ];
//   List<ItemModel> items2 = [];
//   int score = 0;
//   bool gameOver = false;

//   initGame() {
//     items2 = List<ItemModel>.from(items);
//     items.shuffle();
//     items2.shuffle();
//   }

//   @override
//   void initState() {
//     super.initState();
//     initGame();
//   }

//   Widget screen_background(String image) {
//     return Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(
//         fit: BoxFit.cover,
//         image: AssetImage(
//           image, //"assets/images/top3_2.png"
//         ),
//       )),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (items.length == 0) gameOver = true;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<DragNDropBloc>(
//             create: (BuildContext context) => DragNDropBloc(DragNDropRepository(
//                 GameID: widget.GameID, LevelID: widget.LevelId)))
//       ],
//       child: Scaffold(
//           body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage("assets/images/landscape.jpg"),
//             )),
//           ),
//           Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 80),
//                     child: Text.rich(
//                       TextSpan(
//                         children: [
//                           const TextSpan(
//                             text: 'Score: ',
//                             style: TextStyle(
//                                 color: MyAppColors.darkGreen,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                             // Theme.of(context).textTheme.titleMedium,
//                           ),
//                           TextSpan(
//                             text: '$score',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(color: Colors.teal),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (!gameOver)
//                     Row(
//                       children: [
//                         Spacer(),
//                         BlocProvider(
//                           create: (context) => DragNDropBloc(
//                               DragNDropRepository(
//                                   GameID: widget.GameID,
//                                   LevelID: widget.LevelId))
//                             ..add(LoadDragAndDropEvent()),
//                           child: BlocBuilder<DragNDropBloc, DragAndDropState>(
//                             builder: (context, state) {
//                               if (state is DragAndDropLoadingState) {
//                                 return const Center(
//                                   child: CircularProgressIndicator(),
//                                 );
//                               }
//                               if (state is DragAndDropErrorState) {
//                                 print("----------------------staate" +
//                                     state.toString());
//                                 return const Center(child: Text("Error"));
//                               }
//                               if (state is DragAndDropLoadedState) {
//                                 return Column(
//                                   children: state.gameList.map((item) {
//                                     return Container(
//                                       margin: EdgeInsets.all(8),
//                                       child: Draggable<DragAndDrop>(
//                                         data: item,
//                                         childWhenDragging: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           backgroundImage: AssetImage(getImage(state.gameList[0].index1[0].value1)),
//                                           radius: 50,
//                                         ),
//                                         feedback: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           backgroundImage: AssetImage(item.img),
//                                           radius: 30,
//                                         ),
//                                         child: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           backgroundImage: AssetImage(item.img),
//                                           radius: 30,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 );
//                               }
//                               return Container();
//                             },
//                           ),
//                         ),
//                         Spacer(flex: 2),
//                         Column(
//                           children: items2.map((item) {
//                             return DragTarget<ItemModel>(
//                               onAccept: (receivedItem) {
//                                 if (item.value == receivedItem.value) {
//                                   setState(() {
//                                     items.remove(receivedItem);
//                                     items2.remove(item);
//                                   });
//                                   score += 10;
//                                   item.accepting = false;

//                                   // player.play('true.wav');
//                                 } else {
//                                   setState(() {
//                                     item.accepting = false;
//                                     // player.play('false.wav');
//                                   });
//                                 }
//                               },
//                               onWillAccept: (receivedItem) {
//                                 setState(() {
//                                   item.accepting = true;
//                                 });
//                                 return true;
//                               },
//                               onLeave: (receivedItem) {
//                                 setState(() {
//                                   item.accepting = false;
//                                 });
//                               },
//                               builder: (context, acceptedItems,
//                                       rejectedItems) =>
//                                   Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         color: item.accepting
//                                             ? Colors.grey[400]
//                                             : Colors.grey[200],
//                                       ),
//                                       alignment: Alignment.center,
//                                       height:
//                                           MediaQuery.of(context).size.width /
//                                               6.5,
//                                       width:
//                                           MediaQuery.of(context).size.width / 3,
//                                       margin: EdgeInsets.all(8),
//                                       child: Text(
//                                         item.name,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleLarge,
//                                       )),
//                             );
//                           }).toList(),
//                         ),
//                         Spacer(),
//                       ],
//                     ),
//                   if (gameOver)
//                     Center(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               'Game Over',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleLarge!
//                                   .copyWith(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.red),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               result(),
//                               style: Theme.of(context).textTheme.displaySmall,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   if (gameOver)
//                     Container(
//                       height: MediaQuery.of(context).size.width / 10,
//                       decoration: BoxDecoration(
//                           color: Colors.teal,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: TextButton(
//                           onPressed: () {
//                             setState(() {
//                               initGame();
//                             });
//                           },
//                           child: Text(
//                             'New Game',
//                             style: TextStyle(color: Colors.white),
//                           )),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   //Functions:

//   String result() {
//     if (score == 80) {
//       // player.play('success.wav');
//       return 'Awesome!';
//     }
//     return "";
//   }
// }
