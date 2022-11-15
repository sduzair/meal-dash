// ignore: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'meal_dto.g.dart';

@JsonSerializable()
class MealDTO {
  String? mealTitle;
  String? mealShortDescription;
  String? mealLongDescription;
  List<String> mealIngredients = <String>[];
  int? mealCalories;
  int? mealQuantity;
  String mealQuantityUnit = MealQuantityUnit.oz.name;

  MealDTO({
    required this.mealTitle,
    required this.mealShortDescription,
    required this.mealLongDescription,
    required this.mealIngredients,
    required this.mealCalories,
    required this.mealQuantity,
    required this.mealQuantityUnit,
  });

  MealDTO.initializeDummyVals()
      : mealTitle = 'test',
        mealShortDescription = 'test',
        mealLongDescription = 'test',
        mealIngredients = ['test'],
        mealCalories = 765,
        mealQuantity = 10;

  MealDTO.empty();

  factory MealDTO.fromJson(Map<String, dynamic> json) =>
      _$MealDTOFromJson(json);

  get mealImage => null;

  Map<String, dynamic> toJson() => _$MealDTOToJson(this);
}

// part 'meal_model_with_id.g.dart';

@JsonSerializable()
class MealDTOWithId extends MealDTO {
  String mealId;

  MealDTOWithId({
    required this.mealId,
    required super.mealTitle,
    required super.mealShortDescription,
    required super.mealLongDescription,
    required super.mealIngredients,
    required super.mealCalories,
    required super.mealQuantity,
    required super.mealQuantityUnit,
  });

  factory MealDTOWithId.fromJson(Map<String, dynamic> json) =>
      _$MealDTOWithIdFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MealDTOWithIdToJson(this);
}

enum MealQuantityUnit { oz, ml }
