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
      : mealTitle = 'Hyderabadi Biryani',
        mealShortDescription = 'Taste of Hyderabad',
        mealLongDescription =
            'Delicious Hyderabadi Biryani with a hint of spices and a lot of love',
        mealIngredients = ['Rice', 'Chicken', 'Spices', 'Love'],
        mealCalories = 765,
        mealQuantity = 200;

  MealDTO.empty();

  factory MealDTO.fromJson(Map<String, dynamic> json) =>
      _$MealDTOFromJson(json);

  get mealImage => null;

  Map<String, dynamic> toJson() => _$MealDTOToJson(this);
}

// part 'meal_model_with_id.g.dart';

@JsonSerializable()
class MealDTOWithId extends MealDTO {
  @JsonKey(name: 'meal_id')
  int mealId;
  String imagePath;

  MealDTOWithId({
    required this.mealId,
    required super.mealTitle,
    required super.mealShortDescription,
    required super.mealLongDescription,
    required super.mealIngredients,
    required super.mealCalories,
    required super.mealQuantity,
    required super.mealQuantityUnit,
    required this.imagePath,
  });

  factory MealDTOWithId.fromJson(Map<String, dynamic> json) =>
      _$MealDTOWithIdFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MealDTOWithIdToJson(this);

  String get imagePathParsed => imagePath.split('/').last;
}

enum MealQuantityUnit { oz, ml }
