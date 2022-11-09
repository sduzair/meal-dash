import 'package:flutter/material.dart';

class MealsDetailScreen extends StatelessWidget {
  final String mealId;
  const MealsDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Details'),
      ),
      body: Center(
        child: Text('Meal Details $mealId'),
      ),
    );
  }
}
