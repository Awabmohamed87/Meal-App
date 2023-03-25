import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/CategoryItem.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        children: DUMMY_CATEGORIES
            .map((category) =>
                CategoryItem(category.id, category.title, category.color))
            .toList(),
        padding: EdgeInsets.all(25),
      ),
    );
  }
}
