import 'package:flutter/material.dart';
// import 'package:meal_app/screens/navBar_screen.dart';
// import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool glutenFreeFilters = false;
  bool lactoseFreeFilters = false;
  bool veganFreeFilters = false;
  bool vegetarianFreeFilters = false;

  @override
  void initState() {
    super.initState();
    glutenFreeFilters = widget.currentFilters[Filter.glutenFree]!;
    lactoseFreeFilters = widget.currentFilters[Filter.lactoseFree]!;
    veganFreeFilters = widget.currentFilters[Filter.vegan]!;
    vegetarianFreeFilters = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        centerTitle: true,
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meal') {
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => const NavBarScreen()));
      //     }
      //   },
      // ),
      // لإرجاع ما تريد عند الضغط علي زر العودة
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: glutenFreeFilters,
            Filter.lactoseFree: lactoseFreeFilters,
            Filter.vegan: veganFreeFilters,
            Filter.vegetarian: vegetarianFreeFilters,
          });
          return false;
        },
        child: Column(
          children: [
            customSwitch(
              context: context,
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals',
              onChanged: (bool value) {
                setState(() {
                  glutenFreeFilters = value;
                });
              },
              filter: glutenFreeFilters,
            ),
            customSwitch(
              context: context,
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals',
              onChanged: (bool value) {
                setState(() {
                  lactoseFreeFilters = value;
                });
              },
              filter: lactoseFreeFilters,
            ),
            customSwitch(
              context: context,
              title: 'Vegan-free',
              subtitle: 'Only include vegan-free meals',
              onChanged: (bool value) {
                setState(() {
                  veganFreeFilters = value;
                });
              },
              filter: veganFreeFilters,
            ),
            customSwitch(
              context: context,
              title: 'Vegetarian-free',
              subtitle: 'Only include vegetarian-free meals',
              onChanged: (bool value) {
                setState(() {
                  vegetarianFreeFilters = value;
                });
              },
              filter: vegetarianFreeFilters,
            ),
          ],
        ),
      ),
    );
  }

  SwitchListTile customSwitch({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Function(bool newValue) onChanged,
    required bool filter,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
      value: filter,
      onChanged: onChanged,
    );
  }
}
