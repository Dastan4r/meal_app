import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-details';

  final Function markAsFavorite;
  final Function isMealFavorite;

  const MealDetailScreen({required this.markAsFavorite, required this.isMealFavorite });

  Widget buildSectionTitle(String title, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          title,
          style: Theme.of(ctx).textTheme.headline1,
        ),
      ),
    );
  }

  Widget buildContainer(items) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                items[index],
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;

    final selectedMeal = dummyMeals.firstWhere((element) => element.id == args);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildSectionTitle('Ingredients', context),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () => markAsFavorite(selectedMeal.id),
                    icon: isMealFavorite(args) ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite),
                  ),
                ),
              ],
            ),
            buildContainer(selectedMeal.ingredients),
            buildSectionTitle('Steps', context),
            buildContainer(selectedMeal.steps),
          ],
        ),
      ),
    );
  }
}
