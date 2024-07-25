
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_lms_project/business_logic/top3_all_levels_bloc/top3_event.dart';
import 'package:kids_lms_project/business_logic/top3_all_levels_bloc/top3_state.dart';
import 'package:kids_lms_project/data/repository/top3_all_levels_repo.dart';

class TOP3ALLBloc extends Bloc<TOP3ALLEvent, TOP3ALLState> {
  final TOP3ALLRepository _top3allRepository;

  TOP3ALLBloc(this._top3allRepository) : super(TOP3ALLStateLoadingState()) {
    on<LoadTOP3ALLEvent>((event, emit) async {
      emit(TOP3ALLStateLoadingState());

      try {
        final repo = await _top3allRepository.getALLTOPList();
        emit(TOP3ALLStateLoadedState(repo));
      } catch (e) {
        emit(TOP3ALLStateErrorState(e.toString()));
        print("-----rrrr----" + e.toString());
      }
    });
  }
}
