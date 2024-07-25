
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DragAndDropEvent extends Equatable {
  const DragAndDropEvent();
}

class LoadDragAndDropEvent extends DragAndDropEvent {
  const LoadDragAndDropEvent();
  @override
  List<Object> get props => [];
}
