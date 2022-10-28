import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:mealdash_app/features/mealplans/repository/meal_service.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;

class MealViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  
  final MealModel _meal = constants.isTestingMealAdd
      ? MealModel.initializeDummyVals()
      : MealModel.empty();

  MealModel get meal => _meal;

  bool _isAddingMeal = false;
  bool get isAddingMeal => _isAddingMeal;

  bool _isAddingMealError = false;
  bool get isAddingMealError => _isAddingMealError;

  bool _isAddingMealSuccess = false;
  bool get isAddingMealSuccess => _isAddingMealSuccess;

  Future<void> addMeal() async {
    _isAddingMeal = true;
    _isAddingMealError = false;
    notifyListeners();
    try {
      final response = await MealService.addMeal(_meal);
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

  removeIngredientAt({required int index}) {
    meal.mealIngredients?.removeAt(index);
    notifyListeners();
  }

  addIngredient({required String ingredient}) {
    meal.mealIngredients?.add(ingredient);
    notifyListeners();
  }
}
