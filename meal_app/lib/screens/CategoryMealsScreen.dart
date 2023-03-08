import 'package:flutter/material.dart';
import '../widgets/MealItem.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static String routeName = "scr1";
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryMeals = DUMMY_MEALS
        .where((element) => element.categories.contains(args['id']))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(args['title'] + " Receipes"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
              imageUrl: categoryMeals[idx].imageUrl,
              title: categoryMeals[idx].title,
              duration: categoryMeals[idx].duration,
              complexity: categoryMeals[idx].complexity,
              affordability: categoryMeals[idx].affordability);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
