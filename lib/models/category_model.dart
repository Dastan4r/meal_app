import 'package:flutter/material.dart';

class CategoryMeal {
  final String id;
  final String title;
  final Color color;

  const CategoryMeal({this.color = Colors.orange, required this.id, required this.title});
}
