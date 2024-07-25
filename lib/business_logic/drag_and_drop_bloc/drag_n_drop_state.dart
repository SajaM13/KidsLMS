

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/drag_and_drop_model.dart';

@immutable
abstract class DragAndDropState extends Equatable {}

class DragAndDropLoadingState extends DragAndDropState {
  @override
  List<Object?> get props => [];
}

class DragAndDropLoadedState extends DragAndDropState {
  final List<DragAndDrop> gameList;

  DragAndDropLoadedState(this.gameList);

  @override
  List<Object?> get props => [gameList];
}

class DragAndDropErrorState extends DragAndDropState {
  final String error;

  DragAndDropErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
