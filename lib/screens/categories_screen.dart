import 'package:flutter/material.dart';
import 'package:meal_app/widgets/category_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        //Width to length ratio : to Responsive
        childAspectRatio: 3 / 2,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onToggleFavorite: onToggleFavorite,
            availableMeals: availableMeals,
          )
      ],
    );
  }
}
