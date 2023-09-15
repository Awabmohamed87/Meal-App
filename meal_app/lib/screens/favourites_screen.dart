import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal_item.dart';
import '../widgets/main_drawer.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  FavouritesScreenState createState() => FavouritesScreenState();
}

class FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 1.15,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (ctx, idx) {
          return MealItem(
              imageUrl: Provider.of<MealProvider>(context)
                  .favouriteMeals[idx]
                  .imageUrl,
              title:
                  Provider.of<MealProvider>(context).favouriteMeals[idx].title,
              id: Provider.of<MealProvider>(context).favouriteMeals[idx].id,
              duration: Provider.of<MealProvider>(context)
                  .favouriteMeals[idx]
                  .duration,
              complexity: Provider.of<MealProvider>(context)
                  .favouriteMeals[idx]
                  .complexity,
              affordability: Provider.of<MealProvider>(context)
                  .favouriteMeals[idx]
                  .affordability,
              removeMeal: (id) {
                setState(() {
                  Provider.of<MealProvider>(context)
                      .favouriteMeals
                      .removeWhere((element) => element.id == id);
                });
              });
        },
        itemCount: Provider.of<MealProvider>(context).favouriteMeals.length,
      ),
      drawer: const MainDrawer(),
    );
  }
}
