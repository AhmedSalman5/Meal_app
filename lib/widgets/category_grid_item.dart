import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals_screen.dart';
import '../models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onToggleFavorite, required this.availableMeals});

  final Category category;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final List<Meal> filteredMeal = availableMeals
            .where(
              (element) => element.categories.contains(category.id),
            )
            .toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MealsScreen(
              title: category.title,
              meals: filteredMeal,
              toggleFavoriteMealStatus: onToggleFavorite,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.54),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
