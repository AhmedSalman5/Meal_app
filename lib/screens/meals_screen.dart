import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.toggleFavoriteMealStatus});

  final String? title;
  final List<Meal> meals;
  final Function(Meal meal) toggleFavoriteMealStatus;

  @override
  Widget build(BuildContext context) {
    return title == null
        ? containt()
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
              centerTitle: true,
            ),
            body: containt());
  }

  SingleChildScrollView containt() {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map((e) => MealItem(
                  meal: e,
                  toggleFavoriteMealStatus: toggleFavoriteMealStatus,
                ))
            .toList(),
      ),
    );
  }
}
