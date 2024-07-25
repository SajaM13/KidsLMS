import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DragGameEvent extends Equatable {
  const DragGameEvent();
}

class LoadCDragGameEvent extends DragGameEvent {
  // final int levelId;

  LoadCDragGameEvent();
  @override
  List<Object> get props => [];
}
