import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/services/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetAllCategories>((event, emit) async {
      try {
        emit(CategoryLoading());
        final categories = await apiRepository.fetchCategories();
        emit(CategoryLoaded(categories: categories));
      } on NetworkError {
        emit(const CategoryError(
          message: 'Failed to fetch data. ',
        ));
      }
    });
  }
}
