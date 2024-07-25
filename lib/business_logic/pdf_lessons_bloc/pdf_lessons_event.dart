

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PDFLessonsEvent extends Equatable {
  const PDFLessonsEvent();
}

class LoadPdfLessonsEvent extends PDFLessonsEvent {
  @override
  List<Object> get props => [];
}
