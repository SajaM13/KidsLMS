

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/top3_all_levels_bloc/top3_bloc.dart';
import 'package:kids_lms_project/business_logic/top3_all_levels_bloc/top3_event.dart';
import 'package:kids_lms_project/business_logic/top3_all_levels_bloc/top3_state.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/data/repository/top3_all_levels_repo.dart';
import 'package:kids_lms_project/presentation/widgets/card_list.dart';

class top3_all_list_screen extends StatelessWidget {
  String indexID;
  top3_all_list_screen({
    Key? key,
    required this.indexID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("toooooooooooooooooooooooop alllllllll");
    print("$indexID");

    return MultiBlocProvider(
      providers: [
        BlocProvider<TOP3ALLBloc>(
            create: (BuildContext context) => TOP3ALLBloc(TOP3ALLRepository()))
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
                          create: (context) => TOP3ALLBloc(TOP3ALLRepository())
                            ..add(LoadTOP3ALLEvent()),
                          child: BlocBuilder<TOP3ALLBloc, TOP3ALLState>(
                            builder: (context, state) {
                              if (state is TOP3ALLStateLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (state is TOP3ALLStateErrorState) {
                                print("----------------------staate" +
                                    state.toString());
                                return const Center(child: Text("Error"));
                              }
                              if (state is TOP3ALLStateLoadedState) {
                                return ListView.builder(
                                  itemCount: indexID == "TOP 1"
                                      ? state.top3allList[index].top1.length
                                      : indexID == "TOP 2"
                                          ? state.top3allList[index].top2.length
                                          : state
                                              .top3allList[index].top3.length,
                                  itemBuilder: (context, indx) => card_list2(
                                    margin: 8,
                                    routeName: "",
                                    text: indexID == "TOP 1"
                                        ? state
                                            .top3allList[index].top1[indx].name
                                        : indexID == "TOP 2"
                                            ? state.top3allList[index]
                                                .top2[indx].name
                                            : state.top3allList[index]
                                                .top3[indx].name,
                                    subtilte: indexID == "TOP 1"
                                        ? state.top3allList[index].top1[index]
                                            .nickname
                                        : indexID == "TOP 2"
                                            ? state.top3allList[index]
                                                .top2[indx].nickname
                                            : state.top3allList[index]
                                                .top3[indx].nickname,
                                    image: indexID == "TOP 1"
                                        ? state
                                            .top3allList[index].top1[indx].photo
                                        : indexID == "TOP 2"
                                            ? state.top3allList[index]
                                                .top2[indx].photo
                                            : state.top3allList[index]
                                                .top3[indx].photo,
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
