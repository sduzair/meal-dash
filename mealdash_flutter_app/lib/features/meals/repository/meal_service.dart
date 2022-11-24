import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mealdash_app/features/meals/dtos/meal_dto.dart';
import 'package:mealdash_app/service_locator.dart';

class MealService {
  final DioClient dioClient;

  const MealService({required this.dioClient});

  // {mealId: 1, mealTitle: sadf, mealShortDescription: asdf, mealLongDescription: afds, mealIngredients: [34sdf, sadf], mealCalories: null, mealQuantity: 234, mealQuantityUnit: oz}
  // list of meals with mealId, mealTitle, mealShortDescription, mealLongDescription, mealIngredients, mealCalories, mealQuantity, mealQuantityUnit (mealImage)
  static final List<MealDTOWithId> meals = [
    MealDTOWithId(
      mealId: '1',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '2',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '3',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '4',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '5',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '6',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '7',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '8',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '9',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '10',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '11',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '12',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
      mealId: '13',
      mealTitle: 'sadf',
      mealShortDescription: 'asdf',
      mealLongDescription: 'afds',
      mealIngredients: ['34sdf', 'sadf'],
      mealCalories: null,
      mealQuantity: 234,
      mealQuantityUnit: 'oz',
    ),
    MealDTOWithId(
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
  Future<List<MealDTOWithId>> fetchMeals() async {
    await Future.delayed(const Duration(seconds: 1));
    return meals;
  }

  Future<MealDTOWithId> fetchMealById(String mealId) async {
    await Future.delayed(const Duration(seconds: 1));
    return meals.firstWhere((meal) => meal.mealId == mealId);
  }

  Future<Response> addMeal(MealDTO meal, File imageFile) async {
    final String cookieHeader = (await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    ))
        .map((e) => e.toString())
        .join('; ');
    final Response response = await dioClient.dio.post(
      '/meals/add-meal',
      options: Options(
        headers: {
          'Cookie': cookieHeader,
          'Content-Type': 'multipart/form-data',
        },
      ),
      data: FormData.fromMap({
        'mealdata': jsonEncode(meal.toJson()),
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      }),

    );
    return response;
  }

  // static Future<http.Response> addMeal(MealModel mealModel) async {
  //   return http.post(
  //     Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       // 'Authorization': 'Bearer ${constants.token}',
  //     },
  //     body: jsonEncode(mealModel.toJson()),
  //   );
  // }

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

  // static Future<MealModel> getMealById(String mealId) async {
  //   final response = await http.get(
  //     Uri.parse('${constants.apiUrl}/foodvendors/$foodVendorId/meals/$mealId'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return MealModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load meal');
  //   }
  // }
}

// sample get meals body
// body: [
//   {
//     mealId: '1',
//     mealTitle: 'sadf',
//     mealShortDescription: 'asdf',
//     mealLongDescription: 'afds',
//     mealIngredients: ['34sdf', 'sadf'],
//     mealCalories: 345,
//     mealQuantity: 234,
//     mealQuantityUnit: 'oz',
//   },
//   {
//     mealId: '2',
//     mealTitle: 'sadf',
//     mealShortDescription: 'asdf',
//     mealLongDescription: 'afds',
//     mealIngredients: ['34sdf', 'sadf'],
//     mealCalories: null,
//     mealQuantity: 234,
//     mealQuantityUnit: 'oz',
//   },
// ];
