



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/top3_bloc/top3_event.dart';
import 'package:kids_lms_project/business_logic/top3_bloc/top3_state.dart';
import 'package:kids_lms_project/data/repository/top3_repo.dart';

class TOP3Bloc extends Bloc<TOP3Event, TOP3State> {
  final TOP3Repository _top3repository;

  TOP3Bloc(this._top3repository) : super(TOP3StateLoadingState()) {
    on<LoadTOP3Event>((event, emit) async {
      emit(TOP3StateLoadingState());

      try {
        final repo = await _top3repository.getTOPList();
        emit(TOP3StateLoadedState(repo));
      } catch (e) {
        emit(TOP3StateErrorState(e.toString()));
        print("-----rrrr----" + e.toString());
      }
    });
  }
}
