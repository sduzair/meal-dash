// ignore: depend_on_referenced_packages


import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel {
  String? mealTitle;
  String? mealShortDescription;
  String? mealLongDescription;
  List<String>? mealIngredients;
  int? mealCalories;
  int? mealQuantity;
  String mealQuantityUnit = MealQuantityUnit.oz.name;

  MealModel({
    required this.mealTitle,
    required this.mealShortDescription,
    required this.mealLongDescription,
    required this.mealIngredients,
    required this.mealCalories,
    required this.mealQuantity,
    required this.mealQuantityUnit,
  });

  MealModel.initializeDummyVals()
      : mealTitle = 'test',
        mealShortDescription = 'test',
        mealLongDescription = 'test',
        mealIngredients = ['test'],
        mealCalories = 765,
        mealQuantity = 10;

  MealModel.empty() : mealIngredients = ['test'];

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}

// part 'meal_model_with_id.g.dart';

@JsonSerializable()
class MealModelWithId extends MealModel {
  String id;

  MealModelWithId({
    required this.id,
    required super.mealTitle,
    required super.mealShortDescription,
    required super.mealLongDescription,
    required super.mealIngredients,
    required super.mealCalories,
    required super.mealQuantity,
    required super.mealQuantityUnit,
  });

  factory MealModelWithId.fromJson(Map<String, dynamic> json) =>
      _$MealModelWithIdFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MealModelWithIdToJson(this);
}

enum MealQuantityUnit { oz, ml }
