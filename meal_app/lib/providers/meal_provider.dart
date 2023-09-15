import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((element) {
      if (filters['gluten']! && !element.isGlutenFree) return false;
      if (filters['lactose']! && !element.isLactoseFree) return false;
      if (filters['vegan']! && element.isVegan) return false;
      if (filters['vegetarian']! && !element.isVegetarian) return false;
      return true;
    }).toList();
    notifyListeners();

    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
// Save an boolean value to 'repeat' key.
    await prefs.setBool('gluten', filters['gluten']!);
    await prefs.setBool('lactose', filters['lactose']!);
    await prefs.setBool('vegan', filters['vegan']!);
    await prefs.setBool('vegetarian', filters['vegetarian']!);
  }

  void addFavouriteMeal(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favourites = prefs.getStringList('favourites');
    if (favourites == null) {
      prefs.setStringList('favourites', [id]);
    } else {
      favourites.add(id);
      prefs.setStringList('favourites', favourites);
    }
  }

  void deleteFavouriteMeal(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favourites = prefs.getStringList('favourites');
    favourites!.removeWhere((element) => element == id);
    prefs.setStringList('favourites', favourites);
  }

  void emptyFavMeals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favourites', []);
    favouriteMeals = [];
    notifyListeners();
  }

  void loadFilters() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    filters['gluten'] = prefs.getBool('gluten') ?? false;
    filters['lactose'] = prefs.getBool('lactose') ?? false;
    filters['vegan'] = prefs.getBool('vegan') ?? false;
    filters['vegetarian'] = prefs.getBool('vegetarian') ?? false;

    setFilters();

    notifyListeners();
  }

  void loadFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favourites = prefs.getStringList('favourites');
    if (favourites != null) {
      List<Meal> tmp = [];
      for (var element in favourites) {
        tmp.add(DUMMY_MEALS.firstWhere((el) => el.id == element));
      }
      favouriteMeals = tmp;
    }
  }

  void toggleFavourites(String mealID) {
    final newFavMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealID);
    if (favouriteMeals == []) {
      favouriteMeals.add(newFavMeal);
      addFavouriteMeal(mealID);
      return;
    }
    final existingMealIndex =
        favouriteMeals.indexWhere((element) => element.id == mealID);
    if (existingMealIndex == -1) {
      favouriteMeals.add(newFavMeal);
      addFavouriteMeal(mealID);
    } else {
      favouriteMeals.removeAt(existingMealIndex);
      deleteFavouriteMeal(mealID);
    }
    notifyListeners();
  }

  bool isFavourite(String mealID) {
    if (favouriteMeals == []) return false;
    return favouriteMeals.any((element) => element.id == mealID);
  }
}
