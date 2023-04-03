import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filter_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import './screens/CategoryMealsScreen.dart';
import './models/meal.dart';

void main() {
  runApp(MealApp());
}

class MealApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MealAppState createState() => _MealAppState();
}

class _MealAppState extends State<MealApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
      _availableMeals = DUMMY_MEALS.where((element) {
        if (filters['gluten'] && !element.isGlutenFree) return false;
        if (filters['lactose'] && !element.isLactoseFree) return false;
        if (filters['vegan'] && element.isVegan) return false;
        if (filters['vegetarian'] && !element.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFilters(String mealID) {
    setState(() {
      if (_favouriteMeals == null) {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
        return;
      }
      final existingMealIndex =
          _favouriteMeals.indexWhere((element) => element.id == mealID);
      if (existingMealIndex == -1)
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealID));
      else
        _favouriteMeals.removeAt(existingMealIndex);
    });
  }

  bool _isFavourite(String mealID) {
    if (_favouriteMeals == null) return false;
    return _favouriteMeals.any((element) => element.id == mealID);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.grey,
          canvasColor: Color.fromRGBO(239, 239, 240, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              headline6: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'))),
      routes: {
        '/': (context) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_isFavourite, _toggleFilters),
        FilterScreen.routeName: (context) => FilterScreen(filters, _setFilters),
      },
    );
  }
}
