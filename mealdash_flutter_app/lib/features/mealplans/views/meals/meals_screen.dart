import 'package:mealdash_app/utils/constants.dart' as constants;
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                GoRouter.of(context).goNamed(constants.mealsAddRouteName),
          ),
        ],
      ),
      // drawer: const HomeDrawer(),
      body: const Center(
        child: Text('Meals'),
      ),
    );
  }
}
