import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.toggleFavoriteMealStatus});

  final Meal meal;
  final Function(Meal meal) toggleFavoriteMealStatus;

  String complexityText(complexity) {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'UnKnow';
    }
  }

  String affordabilityText(affordability) {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
      default:
        return 'UnKnow';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MealDetailsScreen(
                meal: meal, onToggleFavorite: toggleFavoriteMealStatus,)));
        },
        child: Column(
          children: [
            Stack(
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 15,
                    ),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text(
                          meal.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '${meal.duration} min',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.work,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  complexityText(meal.complexity),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  affordabilityText(meal.affordability),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
