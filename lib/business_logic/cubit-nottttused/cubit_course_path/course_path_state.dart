

import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/path_model.dart';

@immutable
sealed class CubitCoursePathState {}

final class CoursePathInitial extends CubitCoursePathState {}

final class CoursePathLoading extends CubitCoursePathState {}

final class CoursePathLoaded extends CubitCoursePathState {
  final List<Datum> levelsList;

  CoursePathLoaded(this.levelsList);
}

final class CoursePathErrorState extends CubitCoursePathState {
  final String message;

  CoursePathErrorState(this.message);
}
