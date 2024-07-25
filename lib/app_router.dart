import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_bloc.dart';
import 'package:kids_lms_project/data/repository/path_repo.dart';
import 'package:kids_lms_project/presentation/screen/cross_word_puzzle.dart';
import 'package:kids_lms_project/presentation/screen/games_list.dart';
import 'package:kids_lms_project/presentation/screen/lessons_screen.dart';
import 'package:kids_lms_project/presentation/screen/levels_content.dart';
import 'package:kids_lms_project/presentation/screen/login_screen.dart';
import 'package:kids_lms_project/presentation/screen/on_boarding_screen.dart';
import 'package:kids_lms_project/presentation/screen/quiz_screen.dart';
import 'package:kids_lms_project/presentation/screen/splash_screen.dart';
import 'package:kids_lms_project/presentation/screen/top3_levels_names.dart';
import 'package:kids_lms_project/presentation/screen/top3_screen.dart';
import 'package:kids_lms_project/presentation/screen/wordGame2.dart';

import 'constants/strings.dart';

import 'data/models/path_model.dart';
import 'presentation/screen/course_path.dart';
import 'presentation/screen/drag_and_drop_game.dart';
import 'presentation/screen/pdf_screen.dart';
import 'presentation/screen/top3_all_levels_names.dart';

class AppRouter {
  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case main_screen:
        return MaterialPageRoute(builder: (_) => SplashScreen(),//QuizScreen(quizId: 6,),
            // OnBoardingScreen()
            );
      case path_screen:
        return MaterialPageRoute(
            builder: (_) => course_path(
                  levelId: 3,
                ));
      // case main_screen:
      //   return MaterialPageRoute(builder: (_) => LevelsMap_());
      case levels_content:
        return MaterialPageRoute(
            builder: (_) => level_contents(
                  levelid: 1,
                ));
      case lessons_content:
        return MaterialPageRoute(
            builder: (_) => lessons_screen(
                  levelId: 2,
                ));
      case gameslist:
        return MaterialPageRoute(
            builder: (_) => GamesListScreen(
                  levelID: 1,
                ));
      case top3:
        return MaterialPageRoute(
            builder: (_) => top3_screen(
                  levelId: 1,
                ));
      case top3_list:
        return MaterialPageRoute(
            builder: (_) => top3_list_screen(
                  levelID: 1,
                  indexID: '',
                ));
      // case drag_and_drop:
      //   return MaterialPageRoute(builder: (_) => drag_and_drop_screen());
      // case word_search_game:
      //   return MaterialPageRoute(builder: (_) => WordSearchScreen());
      case pdf_screen:
        return MaterialPageRoute(
            builder: (_) => PDFReader(
                  levelID: 1,
                ));

      // default:
    }
    return null;
  }
}
