export interface Meal {
  // meal_id: number;
  vendor_id: number;
  mealTitle: string;
  mealShortDescription: string;
  mealLongDescription: string;
  mealIngredients: string[] | string;
  mealCalories: number;
  mealQuantity: number;
  mealQuantityUnit: string;
  timeStamp: string;
  imagePath: string;
}
