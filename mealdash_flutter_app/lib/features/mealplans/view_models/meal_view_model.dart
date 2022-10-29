import 'package:mealdash_app/utils/constants.dart' as constants;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:mealdash_app/features/mealplans/repository/meal_service.dart';

class MealViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  File? image;

  MealViewModel()
      : meal = constants.isTestingMealAdd
            ? MealModel.initializeDummyVals()
            : MealModel.empty();

  MealModel meal;

  bool _isAddingMeal = false;
  bool get isAddingMeal => _isAddingMeal;

  bool _isAddingMealError = false;
  bool get isAddingMealError => _isAddingMealError;

  bool _isAddingMealSuccess = false;
  bool get isAddingMealSuccess => _isAddingMealSuccess;

  Future<void> addMeal() async {
    print('addMeal() called');
    print(meal.toJson());
    _isAddingMeal = true;
    _isAddingMealError = false;
    notifyListeners();
    try {
      final response = await MealService.addMeal(meal);
      if (response.statusCode == 201) {
        _isAddingMealSuccess = true;
        return;
      } else {
        _isAddingMealError = true;
        return;
      }
    } catch (e) {
      _isAddingMealError = true;
      return;
    } finally {
      _isAddingMeal = false;
      notifyListeners();
    }
  }

  // removeIngredientAt({required MealModel meal, required int index}) {
  //   meal.mealIngredients.removeAt(index);
  //   notifyListeners();
  // }

  // addIngredient({required MealModel meal, required String ingredient}) {
  //   meal.mealIngredients.add(ingredient);
  //   notifyListeners();
  // }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('isAddingMeal',
        value: isAddingMeal, ifTrue: 'Adding Meal'));
    properties.add(FlagProperty('isAddingMealError',
        value: isAddingMealError, ifTrue: 'Adding Meal Error'));
    properties.add(FlagProperty('isAddingMealSuccess',
        value: isAddingMealSuccess, ifTrue: 'Adding Meal Success'));
  }
}
