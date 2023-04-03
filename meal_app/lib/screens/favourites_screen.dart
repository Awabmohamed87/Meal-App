import 'package:flutter/material.dart';
import '../widgets/MealItem.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatefulWidget {
  final List<Meal> _favouriteMeals;

  const FavouritesScreen(this._favouriteMeals);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          return MealItem(
              imageUrl: widget._favouriteMeals[idx].imageUrl,
              title: widget._favouriteMeals[idx].title,
              id: widget._favouriteMeals[idx].id,
              duration: widget._favouriteMeals[idx].duration,
              complexity: widget._favouriteMeals[idx].complexity,
              affordability: widget._favouriteMeals[idx].affordability,
              removeMeal: (id) {
                setState(() {
                  widget._favouriteMeals
                      .removeWhere((element) => element.id == id);
                });
              });
        },
        itemCount: widget._favouriteMeals.length,
      ),
      drawer: MainDrawer(),
    );
  }
}
