import 'package:dio/dio.dart';
import 'package:mealdash_app/service_locator.dart';
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mealdash_app/features/meals/dtos/meal_dto.dart';
import 'package:mealdash_app/features/meals/repository/meal_service.dart';

class MealAddViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  final MealService mealService;

  MealAddViewModel({required this.mealService})
      : _mealDTO = constants.isTestingMealAdd
            ? MealDTO.initializeDummyVals()
            : MealDTO.empty();

  File? imageFile;

  final MealDTO _mealDTO;

  MealDTO get mealDTO => _mealDTO;

  bool _isAddingMeal = false;
  bool get isAddingMeal => _isAddingMeal;

  bool _isAddingMealError = false;
  bool get isAddingMealError => _isAddingMealError;

  String? _addMealErrorMessage;
  String? get addMealErrorMessage => _addMealErrorMessage;

  bool _isAddingMealSuccess = false;
  bool get isAddingMealSuccess => _isAddingMealSuccess;

  bool _showAddingMealSuccessPopup = false;
  bool get showAddingMealSuccessPopup => _showAddingMealSuccessPopup;

  Future<void> addMeal() async {
    print('addMeal() called');
    print(_mealDTO.toJson());
    resetAddMealStateAndNotifyListeners();
    _isAddingMeal = true;
    notifyListeners();
    try {
      await mealService.addMeal(_mealDTO,
        imageFile!,
      ); //* ensure imageFile is not null and this is validated on the meal_add_screen.dart
      _isAddingMealSuccess = true;
      _showAddingMealSuccessPopup = true;
    } on DioError catch (e) {
      _isAddingMealError = true;
      _addMealErrorMessage = DioExceptions.fromDioError(e).message;
    } finally {
      _isAddingMeal = false;
      notifyListeners();
    }
  }

  resetAddMealStateAndNotifyListeners() {
    _isAddingMeal = false;
    _isAddingMealError = false;
    _isAddingMealSuccess = false;
    _addMealErrorMessage = null;
    _showAddingMealSuccessPopup = false;
    notifyListeners();
  }

  resetAddMealState() {
    _isAddingMeal = false;
    _isAddingMealError = false;
    _isAddingMealSuccess = false;
    _addMealErrorMessage = null;
    _showAddingMealSuccessPopup = false;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'isAddingMeal',
        value: isAddingMeal,
        ifTrue: 'Adding Meal',
      ),
    );
    properties.add(
      FlagProperty(
        'isAddingMealError',
        value: isAddingMealError,
        ifTrue: 'Adding Meal Error',
      ),
    );
    properties.add(
      FlagProperty(
        'isAddingMealSuccess',
        value: isAddingMealSuccess,
        ifTrue: 'Adding Meal Success',
      ),
    );
  }
}

class IngredientsProviderAdd extends ChangeNotifier {
  final List<String> _ingredients = [];
  List<String> get ingredients => _ingredients;

  void addIngredient(String ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient({required int index}) {
    _ingredients.removeAt(index);
    notifyListeners();
  }

  bool _isAddingIngredients = true;
  bool get isAddingIngredients => _isAddingIngredients;
  set isAddingIngredients(bool value) {
    _isAddingIngredients = value;
    notifyListeners();
  }
}

class IngredientsProviderEdit extends ChangeNotifier {
  final List<String> _ingredients = [];
  List<String> get ingredients => _ingredients;

  void addIngredient(String ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient({required int index}) {
    _ingredients.removeAt(index);
    notifyListeners();
  }

  bool _isAddingIngredients = true;
  bool get isAddingIngredients => _isAddingIngredients;
  set isAddingIngredients(bool value) {
    _isAddingIngredients = value;
    notifyListeners();
  }
}
