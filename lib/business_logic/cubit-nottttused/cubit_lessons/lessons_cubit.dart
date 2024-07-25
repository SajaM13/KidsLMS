

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/cubit-nottttused/cubit_lessons/lessons_state.dart';
import 'package:kids_lms_project/data/repository/pdf_lessons.dart';

class CoursePathCubit extends Cubit<CubitLessonsState> {
  final PDFLessonsRepository _pdfLessonsRepository;
  CoursePathCubit(
    this._pdfLessonsRepository,
  ) : super(LessonsInitial());
  Future<void> getPDFdata() async {
    try {
      final response = await _pdfLessonsRepository.getlessons();
      emit(LessonshLoaded(response));
    } catch (e) {
      emit(LessonsErrorState(e.toString()));
    }
  }
}
