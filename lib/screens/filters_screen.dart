import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  final Function setFilters;
  final Map<String, bool> filters;

  FiltersScreen({required this.setFilters, required this.filters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactozeFree = false;

  @override
  initState() {
      glutenFree = widget.filters['gluten'] as bool;
      vegetarian = widget.filters['vegetarian'] as bool;
      vegan = widget.filters['vegan'] as bool;
      lactozeFree = widget.filters['lactose'] as bool;

    super.initState();
  }

  Widget renderListTile(bool data, String title, String subtitle) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.primary,
      value: data,
      onChanged: (value) {
        setState(() {
          switch (title) {
            case 'Gluten free':
              setState(() {
                glutenFree = value;
              });
              break;
            case 'Vegetarian':
              setState(() {
                vegetarian = value;
              });
              break;
            case 'Vegan':
              setState(() {
                vegan = value;
              });
              break;
            case 'Lactoze free':
              setState(() {
                lactozeFree = value;
              });
              break;
            default:
          }
        });
      },
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': glutenFree,
                'lactose': lactozeFree,
                'vegan': vegan,
                'vegetarian': vegetarian,
              };
              widget.setFilters(selectedFilters);
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                renderListTile(glutenFree, 'Gluten free',
                    'Only include gluten-free meals'),
                renderListTile(
                    vegetarian, 'Vegetarian', 'Only include vegetarian meals'),
                renderListTile(vegan, 'Vegan', 'Only include vegan meals'),
                renderListTile(lactozeFree, 'Lactoze free',
                    'Only include lactoze-free meals'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
