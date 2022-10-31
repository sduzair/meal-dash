import 'package:flutter/material.dart';

class MealsEditScreen extends StatefulWidget {
  final String mealId;
  const MealsEditScreen({super.key, required this.mealId});

  @override
  State<MealsEditScreen> createState() => _MealsEditScreenState();
}

class _MealsEditScreenState extends State<MealsEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Meal'),
      ),
      body: Center(
        child: Text('Edit Meal ${widget.mealId}'),
      ),
    );
  }
}
