

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kids_lms_project/data/models/top3_model.dart';

@immutable
abstract class TOP3ALLState extends Equatable {}

class TOP3ALLStateLoadingState extends TOP3ALLState {
  @override
  List<Object?> get props => [];
}

class TOP3ALLStateLoadedState extends TOP3ALLState {
  final List<TOP3Data> top3allList;

  TOP3ALLStateLoadedState(this.top3allList);

  @override
  List<Object?> get props => [top3allList];
}

class TOP3ALLStateErrorState extends TOP3ALLState {
  final String error;

  TOP3ALLStateErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
