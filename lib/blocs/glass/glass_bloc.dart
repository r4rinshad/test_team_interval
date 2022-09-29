import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/services/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'glass_event.dart';
part 'glass_state.dart';

class GlassBloc extends Bloc<GlassEvent, GlassState> {
  GlassBloc() : super(GlassInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetAllGlasses>((event, emit) async {
      try {
        emit(GlassLoading());
        final glasses = await apiRepository.fetchGlasses();
        emit(GlassLoaded(glasses: glasses));
      } on NetworkError {
        emit(const GlassError(
          message: 'Failed to fetch data. ',
        ));
      }
    });
  }
}
