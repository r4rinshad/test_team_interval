import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/services/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'alcoholic_event.dart';
part 'alcoholic_state.dart';

class AlcoholicBloc extends Bloc<AlcoholicEvent, AlcoholicState> {
  AlcoholicBloc() : super(AlcoholicInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetAllAlcoholic>((event, emit) async {
      try {
        emit(AlcoholicLoading());
        final alcoholics = await apiRepository.fetchAlcoholics();
        emit(AlcoholicLoaded(alcoholics: alcoholics));
      } on NetworkError {
        emit(const AlcoholicError(
          message: 'Failed to fetch data. ',
        ));
      }
    });
  }
}
