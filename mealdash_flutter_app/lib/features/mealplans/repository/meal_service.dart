import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:http/http.dart' as http;
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'dart:convert';

class MealService {
  static const String foodVendorId = "";

  // {mealId: 1, mealTitle: sadf, mealShortDescription: asdf, mealLongDescription: afds, mealIngredients: [34sdf, sadf], mealCalories: null, mealQuantity: 234, mealQuantityUnit: oz}
  // list of meals with mealId, mealTitle, mealShortDescription, mealLongDescription, mealIngredients, mealCalories, mealQuantity, mealQuantityUnit (mealImage)
  static final List<MealModelWithId> meals = [
    MealModelWithId(
      mealId: '1',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '2',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '3',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '4',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '5',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '6',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '7',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '8',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '9',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '10',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '11',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '12',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '13',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealModelWithId(
      mealId: '14',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
  ];

  // dummy future returning list of meals from meals list above
  static Future<List<MealModelWithId>> getMeals() async {
    await Future.delayed(const Duration(seconds: 1));
    return meals;
  }

  static Future<http.Response> addMeal(MealModel mealModel) async {
    return http.post(
      Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${constants.token}',
      },
      body: jsonEncode(mealModel.toJson()),
    );
  }

  // static Future<List<MealModelWithId>> getMeals() async {
  //   final response = await http.get(
  //     Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     List<dynamic> meals = jsonDecode(response.body);
  //     return meals.map((meal) => MealModelWithId.fromJson(meal)).toList();
  //   } else {
  //     throw Exception('Failed to load meals');
  //   }
  // }

  static Future<MealModel> getMeal(String mealId) async {
    final response = await http.get(
      Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals/$mealId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return MealModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load meal');
    }
  }

  static Future<MealModel> updateMeal(
      String mealId, MealModel mealModel) async {
    final response = await http.put(
      Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals/$mealId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(mealModel.toJson()),
    );
    if (response.statusCode == 200) {
      return MealModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update meal');
    }
  }

  static Future<http.Response> deleteMeal(String mealId) async {
    return http.delete(
      Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals/$mealId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }
}
