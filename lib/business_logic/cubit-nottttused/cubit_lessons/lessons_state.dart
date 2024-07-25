

import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/pdf_lessons_model.dart';

@immutable
sealed class CubitLessonsState {}

final class LessonsInitial extends CubitLessonsState {}

final class LessonsLoading extends CubitLessonsState {}

final class LessonshLoaded extends CubitLessonsState {
  final List<PDFData> pdflist;

  LessonshLoaded(this.pdflist);
}

final class LessonsErrorState extends CubitLessonsState {
  final String message;

  LessonsErrorState(this.message);
}
