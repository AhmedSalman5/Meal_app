import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int initialActiveIndex = 0;
  void changeItem(int value) {
    //print(value);
    setState(() {
      initialActiveIndex = value;
    });
  }

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  List<Meal> favoriteMeal = [];
  //  int numberOfFavorite = favoriteMeal.length;
  void toggleFavoriteMealStatus(Meal meal) {
    final isExisting = favoriteMeal.contains(meal);
    if (isExisting) {
      setState(() {
        favoriteMeal.remove(meal);
      });
      showInfoMessage('Removed from favorites list');
    } else {
      setState(() {
        favoriteMeal.add(meal);
      });
      showInfoMessage('Added to favorites list');
    }
  }

  Map<Filter, bool> selectedFilters = kInitialFilter;

  void setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FiltersScreen(
                  currentFilters: selectedFilters,
                )),
      ).then(
          (value) => setState(() => selectedFilters = value ?? kInitialFilter));
    }
  }

//  else {
//       Navigator.of(context).pop();
//     }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((element) {
      if (selectedFilters[Filter.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: toggleFavoriteMealStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Pick your Categories';

    if (initialActiveIndex == 1) {
      activePage = MealsScreen(
          meals: favoriteMeal,
          toggleFavoriteMealStatus: toggleFavoriteMealStatus);
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: setScreen,
      ),
      bottomNavigationBar: ConvexAppBar.badge(
        backgroundColor: const Color.fromARGB(255, 48, 42, 42),
        badgeMargin: const EdgeInsets.only(bottom: 30, right: 50),
        {if (favoriteMeal.isNotEmpty) 1: '${favoriteMeal.length}'},
        items: const [
          TabItem(
              icon: Icon(
                Icons.set_meal,
                color: Colors.amber,
              ),
              title: 'Categories'),
          TabItem(
              icon: Icon(
                Icons.star,
                color: Colors.amber,
              ),
              title: 'Favorite'),
        ],
        initialActiveIndex: initialActiveIndex,
        onTap: changeItem,
      ),
    );
  }
}
