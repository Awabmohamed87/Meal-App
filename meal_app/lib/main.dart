import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:meal_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import './screens/filter_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MealProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ], child: const MealApp()));
}

class MealApp extends StatefulWidget {
  const MealApp({super.key});

  @override
  MealAppState createState() => MealAppState();
}

class MealAppState extends State<MealApp> {
  @override
  void initState() {
    Provider.of<ThemeProvider>(context, listen: false).loadTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: Provider.of<ThemeProvider>(context).tm,
      theme: ThemeData(
        primarySwatch: Provider.of<ThemeProvider>(context).primaryColor,
        hintColor: Provider.of<ThemeProvider>(context).accentColor,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Colors.white, fontSize: 40),
              bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1), fontSize: 18),
              titleLarge: const TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
            ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Provider.of<ThemeProvider>(context).primaryColor,
        hintColor: Provider.of<ThemeProvider>(context).accentColor,
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        unselectedWidgetColor: Colors.white70,
        iconTheme: const IconThemeData(color: Colors.white),
        cardColor: Colors.black,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Colors.white60),
              bodyMedium: const TextStyle(color: Colors.white70, fontSize: 18),
              titleLarge: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
            ),
      ),
      routes: {
        '/': (context) => const WelcomeScreen(),
        ThemesScreen.routeName: (context) => ThemesScreen(),
        TabsScreen.routeName: (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(),
      },
    );
  }
}
