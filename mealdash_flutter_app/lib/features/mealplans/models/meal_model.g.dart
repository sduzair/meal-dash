// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
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

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'mealTitle': instance.mealTitle,
      'mealShortDescription': instance.mealShortDescription,
      'mealLongDescription': instance.mealLongDescription,
      'mealIngredients': instance.mealIngredients,
      'mealCalories': instance.mealCalories,
      'mealQuantity': instance.mealQuantity,
      'mealQuantityUnit': instance.mealQuantityUnit,
    };

MealModelWithId _$MealModelWithIdFromJson(Map<String, dynamic> json) =>
    MealModelWithId(
      id: json['id'] as String,
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

Map<String, dynamic> _$MealModelWithIdToJson(MealModelWithId instance) =>
    <String, dynamic>{
      'mealTitle': instance.mealTitle,
      'mealShortDescription': instance.mealShortDescription,
      'mealLongDescription': instance.mealLongDescription,
      'mealIngredients': instance.mealIngredients,
      'mealCalories': instance.mealCalories,
      'mealQuantity': instance.mealQuantity,
      'mealQuantityUnit': instance.mealQuantityUnit,
      'id': instance.id,
    };
