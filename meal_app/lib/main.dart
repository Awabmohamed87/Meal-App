import 'package:flutter/material.dart';
import './screens/CategoryMealsScreen.dart';
import './screens/CategoriesScreen.dart';

void main() {
  runApp(MealApp());
}

class MealApp extends StatelessWidget {
  // This widget is the root of your application.
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
        '/': (context) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
      },
    );
  }
}
