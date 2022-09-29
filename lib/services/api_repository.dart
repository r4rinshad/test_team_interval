import 'package:test_team_interval/data/drink.dart';
import 'package:test_team_interval/services/api_provider.dart';

class ApiRepository {


  final _provider = ApiProvider();



  Future<List<Drink>> fetchCategories() {
    return _provider.fetchCategories();
  }

  Future<List<Drink>> fetchGlasses() {
    return _provider.fetchGlasses();
  }

  Future<List<Drink>> fetchAlcoholics() {
    return _provider.fetchAlcoholics();
  }

  Future<List<Drink>> fetchIngredients() {
    return _provider.fetchIngredients();
  }

  Future<List<Drink>> filterByCategory(String categoryName) {
    return _provider.filterByCategory(categoryName);
  }

  Future<List<Drink>> filterByGlass(String glassName) {
    return _provider.filterByGlass(glassName);
  }

  Future<List<Drink>> filterByAlcoholic(String alcoholicOption) {
    return _provider.filterByAlcoholic(alcoholicOption);
  }

  Future<List<Drink>> filterByIngredient(String ingredientName) {
    return _provider.filterByIngredient(ingredientName);
  }

  Future<Drink> fetchDrinkDetails(String drinkName) {
    return _provider.fetchDrinkDetails(drinkName);
  }
}

class NetworkError extends Error {}
