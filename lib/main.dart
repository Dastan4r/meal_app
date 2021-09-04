import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './screens/tabs_screen.dart';
import './screens/categories.dart';
import './screens/meal_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = dummyMeals;
  List<Meal> favoriteMeals = [];

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool isMealFavorite (String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = dummyMeals.where((meal) {
        if (filters['gluten'] != null) {
          if (filters['gluten'] == true && !meal.isGlutenFree) {
            return false;
          } else {
            return true;
          }
        }
        if (filters['lactose'] != null) {
          if (filters['lactose'] == true && !meal.isLactoseFree) {
            return false;
          } else {
            return true;
          }
        }
        if (filters['vegan'] != null) {
          if (filters['vegan'] == true && !meal.isVegan) {
            return false;
          } else {
            return true;
          }
        }
        if (filters['vegetarian'] != null) {
          if (filters['vegetarian'] == true && !meal.isVegetarian) {
            return false;
          } else {
            return true;
          }
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme(
          primary: Colors.teal,
          primaryVariant: Colors.pink,
          secondary: Colors.amber,
          secondaryVariant: Colors.amber.shade600,
          surface: Colors.pink,
          background: Colors.pink,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.amber,
          onSurface: Colors.amber,
          onBackground: Colors.amber,
          onError: Colors.red,
          brightness: Brightness.light,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: const TextStyle(
                fontSize: 22,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
      ),
      routes: {
        '/': (context) => TabsScreen(favoriteMeals: favoriteMeals),
        MealScreen.routeName: (context) =>
            MealScreen(availableMeals: availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              markAsFavorite: toggleFavorite,
              isMealFavorite: isMealFavorite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              setFilters: setFilters,
              filters: filters,
            ),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal app'),
      ),
      body: const Center(
        child: Text('test'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
