import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_event.dart';
import 'package:kids_lms_project/business_logic/course_path_bloc/course_path_state.dart';
import 'package:kids_lms_project/data/models/path_model.dart';

import '../../data/repository/drag_game_repo.dart';
import '../../data/repository/path_repo.dart';
import 'drag_game_event.dart';
import 'drag_game_state.dart';

class DragGameBloc extends Bloc<DragGameEvent, DragGameState> {
  final DragGameRepository _dragGameRepository;

  DragGameBloc(this._dragGameRepository) : super(DragGameLoadingState()) {
    on<LoadCDragGameEvent>((event, emit) async {
      emit(DragGameLoadingState());

      try {
        final repo = await _dragGameRepository.getDragGame();
        // final ID = await _coursepathrepo.getLevels();
        emit(DragGameLoadedState(repo));
      } catch (e) {
        emit(DragGameErrorState(e.toString()));
        print("-----rrrr----" + e.toString());
      }
    });
  }
}
