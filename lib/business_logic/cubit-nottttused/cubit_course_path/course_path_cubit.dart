import 'package:bloc/bloc.dart';
import 'package:kids_lms_project/business_logic/cubit-nottttused/cubit_course_path/course_path_state.dart';
import 'package:kids_lms_project/data/models/path_model.dart';
import 'package:kids_lms_project/data/repository/path_repo.dart';
import 'package:meta/meta.dart';



class CoursePathCubit extends Cubit<CubitCoursePathState> {
  final coursePathRepository _coursePathRepository;
  CoursePathCubit(
    this._coursePathRepository,
  ) : super(CoursePathInitial());
  Future<void> getPathdata() async {
    try {
      final response = await _coursePathRepository.getLevels();
      emit(CoursePathLoaded(response));
    } catch (e) {
      emit(CoursePathErrorState(e.toString()));
    }
  }
}
