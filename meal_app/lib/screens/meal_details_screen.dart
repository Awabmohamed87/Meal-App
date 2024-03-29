import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "meal_detail_screen";
  const MealDetailScreen({super.key});

  Widget buildSectionTitle(context, String str) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        str,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildBox(Widget child) {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(right: 5, bottom: 5, left: 5),
      padding: const EdgeInsets.only(right: 5, bottom: 5, left: 5),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((element) => element.id == id);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(selectedMeal.title),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: id,
                child: InteractiveViewer(
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      selectedMeal.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      buildSectionTitle(context, "Ingredients"),
                      buildBox(ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (ctx, index) {
                          return Card(
                            color: const Color.fromRGBO(236, 236, 236, 1),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(selectedMeal.ingredients[index])),
                          );
                        },
                        itemCount: selectedMeal.ingredients.length,
                      )),
                      buildSectionTitle(context, "Steps"),
                      buildBox(
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text("# ${index + 1}"),
                                  ),
                                  title: Text(selectedMeal.steps[index]),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                          itemCount: selectedMeal.steps.length,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          buildSectionTitle(context, "Ingredients"),
                          buildBox(ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (ctx, index) {
                              return Card(
                                color: const Color.fromRGBO(236, 236, 236, 1),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child:
                                        Text(selectedMeal.ingredients[index])),
                              );
                            },
                            itemCount: selectedMeal.ingredients.length,
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          buildSectionTitle(context, "Steps"),
                          buildBox(
                            ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Text("# ${index + 1}"),
                                      ),
                                      title: Text(selectedMeal.steps[index]),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
                              itemCount: selectedMeal.steps.length,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Provider.of<MealProvider>(context, listen: false)
              .toggleFavourites(selectedMeal.id);
        },
        child: Icon(
          Provider.of<MealProvider>(context).isFavourite(selectedMeal.id)
              ? Icons.star
              : Icons.star_border,
          color: Colors.white,
        ),
      ),
    );
  }
}
