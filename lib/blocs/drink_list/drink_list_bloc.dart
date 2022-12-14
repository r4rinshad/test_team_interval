import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/services/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drink_list_event.dart';
part 'drink_list_state.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  DrinkListBloc() : super(DrinkListInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<SearchByCategory>((event, emit) async {
      try {
        emit(DrinkListLoading());
        final drinks = await apiRepository.filterByCategory(event.categoryName);
        emit(DrinkListLoaded(drinks: drinks));
      } on NetworkError {
        emit(const DrinkListError(
          message: 'Failed to fetch data. ',
        ));
      }
    });

    on<SearchByGlass>((event, emit) async {
      try {
        emit(DrinkListLoading());
        final drinks = await apiRepository.filterByGlass(event.glassName);
        emit(DrinkListLoaded(drinks: drinks));
      } on NetworkError {
        emit(const DrinkListError(
          message: 'Failed to fetch data.',
        ));
      }
    });

    on<SearchByAlcoholic>((event, emit) async {
      try {
        emit(DrinkListLoading());
        final drinks =
            await apiRepository.filterByAlcoholic(event.alcoholicOption);
        emit(DrinkListLoaded(drinks: drinks));
      } on NetworkError {
        emit(const DrinkListError(
          message: 'Failed to fetch data. ',
        ));
      }
    });

    on<SearchByIngredient>((event, emit) async {
      try {
        emit(DrinkListLoading());
        final drinks =
            await apiRepository.filterByIngredient(event.ingredientName);
        emit(DrinkListLoaded(drinks: drinks));
      } on NetworkError {
        emit(const DrinkListError(
          message: 'Failed to fetch data. ',
        ));
      }
    });
  }
}
