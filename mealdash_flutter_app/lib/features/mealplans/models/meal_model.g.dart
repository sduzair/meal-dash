// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      mealName: json['mealName'] as String?,
      mealDescription: json['mealDescription'] as String?,
      mealIngredients: (json['mealIngredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mealCalories: json['mealCalories'] as String?,
      mealWeight: json['mealWeight'] as String?,
      mealTags: (json['mealTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mealImageUri: json['mealImageUri'] as String?,
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'mealName': instance.mealName,
      'mealDescription': instance.mealDescription,
      'mealIngredients': instance.mealIngredients,
      'mealCalories': instance.mealCalories,
      'mealWeight': instance.mealWeight,
      'mealTags': instance.mealTags,
      'mealImageUri': instance.mealImageUri,
    };

MealModelWithId _$MealModelWithIdFromJson(Map<String, dynamic> json) =>
    MealModelWithId(
      id: json['id'] as String?,
      mealName: json['mealName'] as String,
      mealDescription: json['mealDescription'] as String,
      mealIngredients: (json['mealIngredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mealCalories: json['mealCalories'] as String,
      mealWeight: json['mealWeight'] as String,
      mealTags:
          (json['mealTags'] as List<dynamic>).map((e) => e as String).toList(),
      mealImageUri: json['mealImageUri'] as String,
    );

Map<String, dynamic> _$MealModelWithIdToJson(MealModelWithId instance) =>
    <String, dynamic>{
      'mealName': instance.mealName,
      'mealDescription': instance.mealDescription,
      'mealIngredients': instance.mealIngredients,
      'mealCalories': instance.mealCalories,
      'mealWeight': instance.mealWeight,
      'mealTags': instance.mealTags,
      'mealImageUri': instance.mealImageUri,
      'id': instance.id,
    };
