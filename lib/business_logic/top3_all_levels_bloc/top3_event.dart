

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TOP3ALLEvent extends Equatable {
  const TOP3ALLEvent();
}

class LoadTOP3ALLEvent extends TOP3ALLEvent {
  @override
  List<Object> get props => [];
}
