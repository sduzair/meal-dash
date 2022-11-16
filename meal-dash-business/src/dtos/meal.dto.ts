/* eslint-disable prettier/prettier */
import { IsBoolean, IsArray, IsNumber, IsString } from 'class-validator';

export class MealDto {
  @IsNumber()
  public vendor_id: number;

  @IsString()
  public mealTitle: string;

  @IsString()
  public mealShortDescription: string;

  @IsString()
  public mealLongDescription: string;

  @IsArray()
  public mealIngredients: string[];

  @IsNumber()
  public mealCalories: number;

  @IsNumber()
  public mealQuantity: number;

  @IsString()
  public mealQuantityUnit: string;

  @IsString()
  public timeStamp: string;
}
