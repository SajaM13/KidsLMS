

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_event.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_state.dart';
import 'package:kids_lms_project/data/repository/path_repo.dart';

class CoursePathBloc extends Bloc<CoursPathEvent, CoursPathState> {
  final coursePathRepository _coursepathrepo;

  CoursePathBloc(this._coursepathrepo) : super(CoursPathLoadingState()) {
    on<LoadCoursepathEvent>((event, emit) async {
      emit(CoursPathLoadingState());

      try {
        final repo = await _coursepathrepo.getLevels();
        // final ID = await _coursepathrepo.getLevels();
        emit(CoursPathLoadedState(repo));
      } catch (e) {
        emit(CoursPathErrorState(e.toString()));
        print("-----rrrr----" + e.toString());
      }
    });
  }
}
