import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final String id;
  final Function removeMeal;

  const MealItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.id,
      required this.removeMeal});

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((value) {
      if (value != null) removeMeal(value);
    });
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";
      case Complexity.Hard:
        return "Hard";

      case Complexity.Challenging:
        return "Challenging";

      default:
        return "Unknown";
    }
  }

  String get affotrdabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";

      case Affordability.Luxurious:
        return "Luxurious";

      case Affordability.Pricey:
        return "Pricey";

      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageUrl: imageUrl,
                    errorWidget: (context, url, error) => const Text('error'),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 300,
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(width: 5),
                      Text("$duration min"),
                    ],
                  ),
                  Row(children: [
                    const Icon(Icons.work),
                    const SizedBox(width: 5),
                    Text(complexityText),
                  ]),
                  Row(children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(width: 5),
                    Text(affotrdabilityText),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
