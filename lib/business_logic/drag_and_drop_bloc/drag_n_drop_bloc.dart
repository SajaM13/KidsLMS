

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/drag_and_drop_bloc/drag_n_drop_event.dart';
import 'package:kids_lms_project/business_logic/drag_and_drop_bloc/drag_n_drop_state.dart';
import 'package:kids_lms_project/data/repository/drag_and_drop_repo.dart';

class DragNDropBloc extends Bloc<DragAndDropEvent, DragAndDropState> {
  final DragNDropRepository _dragNDropRepository;

  DragNDropBloc(this._dragNDropRepository) : super(DragAndDropLoadingState()) {
    on<LoadDragAndDropEvent>((event, emit) async {
      emit(DragAndDropLoadingState());

      try {
        final repo = await _dragNDropRepository.getLevels();
        emit(DragAndDropLoadedState(repo));
      } catch (e) {
        emit(DragAndDropErrorState(e.toString()));
        print("-----rrrr----" + e.toString());
      }
    });
  }
}
