import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/path_model.dart';

import '../../data/models/drag_n_drop_model.dart';

@immutable
abstract class DragGameState extends Equatable {}

class DragGameLoadingState extends DragGameState {
  @override
  List<Object?> get props => [];
}

class DragGameLoadedState extends DragGameState {
  final List<DragNDrop> dragGameList;

  DragGameLoadedState(this.dragGameList);

  @override
  List<Object?> get props => [dragGameList];
}

class DragGameErrorState extends DragGameState {
  final String error;

  DragGameErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
