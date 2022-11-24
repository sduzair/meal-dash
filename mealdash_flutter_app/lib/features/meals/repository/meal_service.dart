import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mealdash_app/features/meals/dtos/meal_dto.dart';
import 'package:mealdash_app/service_locator.dart';

class MealService {
  final DioClient dioClient;

  const MealService({required this.dioClient});

  Future<List<MealDTOWithId>> fetchMeals() async {
    final String cookieHeader = (await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    ))
        .map((e) => e.toString())
        .join('; ');
    final Response response = await dioClient.dio.get(
      '/meals',
      options: Options(
        headers: {
          'Cookie': cookieHeader,
        },
      ),
    );
    // print(response.data.toString());
    final List<dynamic> mealsJson = response.data["data"];
    return mealsJson.map((e) => MealDTOWithId.fromJson(e)).toList();
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

  Future<MealDTOWithId> fetchMealById(int id) async {
    final String cookieHeader = (await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    ))
        .map((e) => e.toString())
        .join('; ');
    final Response response = await dioClient.dio.get(
      '/meals/$id',
      options: Options(
        headers: {
          'Cookie': cookieHeader,
        },
      ),
    );
    return MealDTOWithId.fromJson(response.data["data"]);
  }

  Future<Response> updateMeal(MealDTOWithId meal, File imageFile) async {
    final String cookieHeader = (await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    ))
        .map((e) => e.toString())
        .join('; ');
    final Response response = await dioClient.dio.post(
      '/meals/${meal.mealId}',
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

  Future<Response> deleteMeal(int mealId) async {
    final String cookieHeader = (await dioClient.cookieJar.loadForRequest(
      Uri.parse('${Endpoints.baseUrl}/login'),
    ))
        .map((e) => e.toString())
        .join('; ');
    final Response response = await dioClient.dio.post(
      '/meals/$mealId',
      options: Options(
        headers: {
          'Cookie': cookieHeader,
        },
      ),
      data: {
        'mealId': mealId,
      },
    );
    return response;
  }
}

// sample get meals body
// {"data":[{"meal_id":1,"vendor_id":1,"mealTitle":"test","mealShortDescription":"test","mealLongDescription":"test","mealIngredients":["test"],"mealCalories":765,"mealQuantity":10,"mealQuantityUnit":"oz","timeStamp":"1669277587463","imagePath":"/usr/src/app/dist/upload_cc61863c3ad689f129591afbc3f5c2a4.jpg"},{"meal_id":2,"vendor_id":1,"mealTitle":"test","mealShortDescription":"test","mealLongDescription":"test","mealIngredients":["test"],"mealCalories":765,"mealQuantity":10,"mealQuantityUnit":"oz","timeStamp":"1669277587463","imagePath":"/usr/src/app/dist/upload_c130e0ad8bd1232cd248b6828019edb5.jpg"},{"meal_id":3,"vendor_id":1,"mealTitle":"test","mealShortDescription":"test","mealLongDescription":"test","mealIngredients":["test"],"mealCalories":765,"mealQuantity":10,"mealQuantityUnit":"oz","timeStamp":"1669277587463","imagePath":"/usr/src/app/dist/upload_a88dd8fe384ada2e535e02c28bf48a12.jpg"}],"message":"findAll"}
