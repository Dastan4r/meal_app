import 'package:flutter/material.dart';

import './categories.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal_model.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen({required this.favoriteMeals});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages = [];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoriteScreen(favoriteMeals: widget.favoriteMeals),
        'title': 'Favorites'
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.collections, color: Colors.white),
              label: 'Categories',
              backgroundColor: Colors.teal,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star, color: Colors.white),
              label: 'Favorites',
              backgroundColor: Colors.teal,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedPageIndex,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 16,
          unselectedFontSize: 14,
        ));
  }
}
