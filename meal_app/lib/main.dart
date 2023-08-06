import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import './screens/filter_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MealProvider(), child: const MealApp()));
}

class MealApp extends StatefulWidget {
  const MealApp({super.key});

  @override
  MealAppState createState() => MealAppState();
}

class MealAppState extends State<MealApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          hintColor: Colors.grey,
          canvasColor: const Color.fromRGBO(239, 239, 240, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
              titleLarge: const TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'))),
      routes: {
        '/': (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FilterScreen.routeName: (context) => const FilterScreen(),
      },
    );
  }
}
