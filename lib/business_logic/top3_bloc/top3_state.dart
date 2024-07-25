

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/top3_in_level_model.dart';

@immutable
abstract class TOP3State extends Equatable {}

class TOP3StateLoadingState extends TOP3State {
  @override
  List<Object?> get props => [];
}

class TOP3StateLoadedState extends TOP3State {
  final List<TOP3LevelData> top3List;

  TOP3StateLoadedState(this.top3List);

  @override
  List<Object?> get props => [top3List];
}

class TOP3StateErrorState extends TOP3State {
  final String error;

  TOP3StateErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
