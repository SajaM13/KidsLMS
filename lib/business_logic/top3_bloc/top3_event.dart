

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TOP3Event extends Equatable {
  const TOP3Event();
}

class LoadTOP3Event extends TOP3Event {
  @override
  List<Object> get props => [];
}
