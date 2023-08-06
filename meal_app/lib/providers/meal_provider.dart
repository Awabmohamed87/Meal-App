import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

import '../dummy_data.dart';

class MealProvider with ChangeNotifier {
  List<Meal> favouriteMeals = [];
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> availableMeals = DUMMY_MEALS;

  void setFilters() {
    availableMeals = DUMMY_MEALS.where((element) {
      if (filters['gluten']! && !element.isGlutenFree) return false;
      if (filters['lactose']! && !element.isLactoseFree) return false;
      if (filters['vegan']! && element.isVegan) return false;
      if (filters['vegetarian']! && !element.isVegetarian) return false;
      return true;
    }).toList();
    notifyListeners();
  }

  void toggleFavourites(String mealID) {
    if (favouriteMeals == []) {
      favouriteMeals
          .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
      return;
    }
    final existingMealIndex =
        favouriteMeals.indexWhere((element) => element.id == mealID);
    if (existingMealIndex == -1) {
      favouriteMeals
          .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
    } else {
      favouriteMeals.removeAt(existingMealIndex);
    }
    notifyListeners();
  }

  bool isFavourite(String mealID) {
    if (favouriteMeals == []) return false;
    return favouriteMeals.any((element) => element.id == mealID);
  }
}
