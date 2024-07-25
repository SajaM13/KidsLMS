
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CoursPathEvent extends Equatable {
  const CoursPathEvent();
}

class LoadCoursepathEvent extends CoursPathEvent {
  // final int levelId;

  LoadCoursepathEvent();
  @override
  List<Object> get props => [];
}
