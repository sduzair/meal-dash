/* eslint-disable prettier/prettier */
import { IsBoolean, IsArray, IsNumber, IsString } from 'class-validator';

export class MealDto {
  
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

  public image: string;
  public imagePath: string;

}
