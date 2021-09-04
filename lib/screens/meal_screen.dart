import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal_model.dart';

class MealScreen extends StatefulWidget {
  static const String routeName = '/meals';

  final List<Meal> availableMeals;

  MealScreen({ required this.availableMeals });

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late String? categoryTitle;
  late List<Meal> displayedMeals;

  bool loadInitData = false;

  @override
  void didChangeDependencies() {
    if (!loadInitData) {
      final routeArguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArguments['title'];
      final categoryId = routeArguments['id'];

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      loadInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            categoryTitle!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (cts, index) {
            return MealItem(
              id: displayedMeals[index].id,
              complexity: displayedMeals[index].complexity,
              cost: displayedMeals[index].cost,
              duration: displayedMeals[index].duration,
              imageUrl: displayedMeals[index].imageUrl,
              title: displayedMeals[index].title,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
