import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static String routeName = "scr1";

  const CategoryMealsScreen({super.key});
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal>? categoryMeals;
  Map<String, String>? args;
  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryMeals = Provider.of<MealProvider>(context)
        .availableMeals
        .where((element) => element.categories.contains(args!['id']))
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${args!['title']} Receipes"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
              imageUrl: categoryMeals![idx].imageUrl,
              title: categoryMeals![idx].title,
              id: categoryMeals![idx].id,
              duration: categoryMeals![idx].duration,
              complexity: categoryMeals![idx].complexity,
              affordability: categoryMeals![idx].affordability,
              removeMeal: (id) {
                setState(() {
                  categoryMeals!.removeWhere((element) => element.id == id);
                });
              });
        },
        itemCount: categoryMeals!.length,
      ),
      drawer: const MainDrawer(),
    );
  }
}