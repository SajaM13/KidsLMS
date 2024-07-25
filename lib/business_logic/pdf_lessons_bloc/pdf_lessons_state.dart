

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/pdf_lessons_model.dart';

@immutable
abstract class PDFLessonsState extends Equatable {}

class PDFLessonsLoadingState extends PDFLessonsState {
  @override
  List<Object?> get props => [];
}

class PDFLessonsLoadedState extends PDFLessonsState {
  final List<PDFData> pdflist;

  PDFLessonsLoadedState(this.pdflist);

  @override
  List<Object?> get props => [pdflist];
}

class PDFLessonsErrorState extends PDFLessonsState {
  final String error;

  PDFLessonsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
