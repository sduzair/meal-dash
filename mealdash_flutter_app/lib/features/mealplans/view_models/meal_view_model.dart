import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:mealdash_app/features/mealplans/repository/meal_service.dart';

class MealViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isAddingMeal = false;
  bool get isAddingMeal => _isAddingMeal;

  bool _isAddingMealError = false;
  bool get isAddingMealError => _isAddingMealError;

  bool _isAddingMealSuccess = false;
  bool get isAddingMealSuccess => _isAddingMealSuccess;

  Future<void> addMeal(MealModel mealModel) async {
    _isAddingMeal = true;
    _isAddingMealError = false;
    notifyListeners();
    try {
      final response = await MealService.addMeal(mealModel);
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
}
