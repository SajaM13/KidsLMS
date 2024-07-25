import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/top3_bloc/top3_bloc.dart';
import 'package:kids_lms_project/business_logic/top3_bloc/top3_event.dart';
import 'package:kids_lms_project/business_logic/top3_bloc/top3_state.dart';
import 'package:kids_lms_project/data/repository/top3_repo.dart';
import 'package:kids_lms_project/presentation/widgets/card_list.dart';

import '../../constants/colors.dart';
import '../widgets/image_decoding.dart';

class top3_list_screen extends StatelessWidget {
  int levelID;
  String indexID;
  top3_list_screen({
    Key? key,
    required this.levelID,
    required this.indexID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("toooooooooooooooooooooooop");
    print("$indexID");

    return MultiBlocProvider(
      providers: [
        BlocProvider<TOP3Bloc>(
            create: (BuildContext context) =>
                TOP3Bloc(TOP3Repository(LevelID: levelID)))
      ],
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/top3_2.png",
              ),
            )),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Container(
                child: SizedBox(
                  width: 360,
                  height: 800,
                  child: Column(
                    children: [
                      Expanded(
                        child: BlocProvider(
                          create: (context) =>
                              TOP3Bloc(TOP3Repository(LevelID: levelID))
                                ..add(LoadTOP3Event()),
                          child: BlocBuilder<TOP3Bloc, TOP3State>(
                            builder: (context, state) {
                              if (state is TOP3StateLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is TOP3StateErrorState) {
                                print("----------------------staate" +
                                    state.toString());
                                return const Center(child: Text("Error"));
                              }
                              if (state is TOP3StateLoadedState) {
                                return ListView.builder(
                                  itemCount: indexID == "TOP 1"
                                      ? state.top3List[index].topThree95.length
                                      : indexID == "TOP 2"
                                          ? state
                                              .top3List[index].topThree80.length
                                          : state.top3List[index].topThree60
                                              .length,
                                  itemBuilder: (context, indx) => card_list2(
                                    margin: 8,
                                    routeName: "",
                                    text: indexID == "TOP 1"
                                        ? state.top3List[index].topThree95[indx]
                                            .name
                                        : indexID == "TOP 2"
                                            ? state.top3List[index]
                                                .topThree80[indx].name
                                            : state.top3List[index]
                                                .topThree60[indx].name,
                                    subtilte: indexID == "TOP 1"
                                        ? state.top3List[index]
                                            .topThree95[index].nickname
                                        : indexID == "TOP 2"
                                            ? state.top3List[index]
                                                .topThree80[indx].nickname
                                            : state.top3List[index]
                                                .topThree60[indx].nickname,
                                    image: indexID == "TOP 1"
                                        ? state.top3List[index].topThree95[indx]
                                            .photo
                                        : indexID == "TOP 2"
                                            ? state.top3List[index]
                                                .topThree80[indx].photo
                                            : state.top3List[index]
                                                .topThree60[indx].photo,
                                    color: MyAppColors.purple,
                                    fontsize: 18,
                                    color2: MyAppColors.darkGray,
                                    fontsize2: 14,
                                    function: () {},
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
