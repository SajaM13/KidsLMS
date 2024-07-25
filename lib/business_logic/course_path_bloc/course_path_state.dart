

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/path_model.dart';

@immutable
abstract class CoursPathState extends Equatable {}

class CoursPathLoadingState extends CoursPathState {
  @override
  List<Object?> get props => [];
}

class CoursPathLoadedState extends CoursPathState {
  final List<Datum> coursePathlist;

  CoursPathLoadedState(this.coursePathlist);

  @override
  List<Object?> get props => [coursePathlist];
}

class CoursPathErrorState extends CoursPathState {
  final String error;

  CoursPathErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
