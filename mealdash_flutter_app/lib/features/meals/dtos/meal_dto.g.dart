// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDTO _$MealDTOFromJson(Map<String, dynamic> json) => MealDTO(
      mealTitle: json['mealTitle'] as String?,
      mealShortDescription: json['mealShortDescription'] as String?,
      mealLongDescription: json['mealLongDescription'] as String?,
      mealIngredients: (json['mealIngredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mealCalories: json['mealCalories'] as int?,
      mealQuantity: json['mealQuantity'] as int?,
      mealQuantityUnit: json['mealQuantityUnit'] as String,
    );

Map<String, dynamic> _$MealDTOToJson(MealDTO instance) => <String, dynamic>{
      'mealTitle': instance.mealTitle,
      'mealShortDescription': instance.mealShortDescription,
      'mealLongDescription': instance.mealLongDescription,
      'mealIngredients': instance.mealIngredients,
      'mealCalories': instance.mealCalories,
      'mealQuantity': instance.mealQuantity,
      'mealQuantityUnit': instance.mealQuantityUnit,
    };

MealDTOWithId _$MealDTOWithIdFromJson(Map<String, dynamic> json) =>
    MealDTOWithId(
      mealId: json['mealId'] as String,
      mealTitle: json['mealTitle'] as String?,
      mealShortDescription: json['mealShortDescription'] as String?,
      mealLongDescription: json['mealLongDescription'] as String?,
      mealIngredients: (json['mealIngredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mealCalories: json['mealCalories'] as int?,
      mealQuantity: json['mealQuantity'] as int?,
      mealQuantityUnit: json['mealQuantityUnit'] as String,
    );

Map<String, dynamic> _$MealDTOWithIdToJson(MealDTOWithId instance) =>
    <String, dynamic>{
      'mealTitle': instance.mealTitle,
      'mealShortDescription': instance.mealShortDescription,
      'mealLongDescription': instance.mealLongDescription,
      'mealIngredients': instance.mealIngredients,
      'mealCalories': instance.mealCalories,
      'mealQuantity': instance.mealQuantity,
      'mealQuantityUnit': instance.mealQuantityUnit,
      'mealId': instance.mealId,
    };
