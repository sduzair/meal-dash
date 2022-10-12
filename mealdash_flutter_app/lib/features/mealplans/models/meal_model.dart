// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel {
  String? mealName;
  String? mealDescription;
  List<String>? mealIngredients;
  String? mealCalories;
  String? mealWeight;
  List<String>? mealTags;
  String? mealImageUri;

  MealModel({
    required this.mealName,
    required this.mealDescription,
    required this.mealIngredients,
    required this.mealCalories,
    required this.mealWeight,
    required this.mealTags,
    required this.mealImageUri,
  });

  MealModel.initializeDummyVals()
      : mealName = 'test',
        mealDescription = 'test',
        mealIngredients = ['test'],
        mealCalories = 'test',
        mealWeight = 'test',
        mealTags = ['test'],
        mealImageUri = 'test';

  MealModel.empty();

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}

// part 'meal_model_with_id.g.dart';

@JsonSerializable()
class MealModelWithId extends MealModel {
  String? id;

  MealModelWithId({
    required this.id,
    required String mealName,
    required String mealDescription,
    required List<String> mealIngredients,
    required String mealCalories,
    required String mealWeight,
    required List<String> mealTags,
    required String mealImageUri,
  }) : super(
          mealName: mealName,
          mealDescription: mealDescription,
          mealIngredients: mealIngredients,
          mealCalories: mealCalories,
          mealWeight: mealWeight,
          mealTags: mealTags,
          mealImageUri: mealImageUri,
        );

  MealModelWithId.empty() : super.empty();

  factory MealModelWithId.fromJson(Map<String, dynamic> json) =>
      _$MealModelWithIdFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MealModelWithIdToJson(this);
}
