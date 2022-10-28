import 'package:flutter/material.dart';

class MealPlansScreen extends StatelessWidget {
  const MealPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plans'),
      ),
      // drawer: const HomeDrawer(),
      body: const Center(
        child: Text('Meal Plans'),
      ),
    );
  }
}
