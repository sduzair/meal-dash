import 'package:mealdash_app/features/mealplans/models/meal_model.dart';
import 'package:http/http.dart' as http;
import 'package:mealdash_app/utils/constants.dart' as constants;
import 'dart:convert';

class MealService {
  static const String foodVendorId = "";

  static Future<http.Response> addMeal(MealModel mealModel) async {
    return http.post(
      Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(mealModel.toJson()),
    );
  }

  static Future<List<MealModelWithId>> getMeals() async {
    final response = await http.get(
      Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> meals = jsonDecode(response.body);
      return meals.map((meal) => MealModelWithId.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

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
