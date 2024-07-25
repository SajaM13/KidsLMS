

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_event.dart';
import 'package:kids_lms_project/business_logic/pdf_lessons_bloc/pdf_lessons_state.dart';
import 'package:kids_lms_project/data/repository/pdf_lessons.dart';

class PDFLessonsBloc extends Bloc<PDFLessonsEvent, PDFLessonsState> {
  final PDFLessonsRepository _pdfLessonsRepository;

  PDFLessonsBloc(this._pdfLessonsRepository) : super(PDFLessonsLoadingState()) {
    on<LoadPdfLessonsEvent>((event, emit) async {
      emit(PDFLessonsLoadingState());

      try {
        final repo = await _pdfLessonsRepository.getlessons();
        emit(PDFLessonsLoadedState(repo));
      } catch (e) {
        emit(PDFLessonsErrorState(e.toString()));
        print("-----rrrr----" + e.toString());
      }
    });
  }
}
