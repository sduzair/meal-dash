/* eslint-disable prettier/prettier */
import { IsBoolean, IsArray, IsNumber, IsString, IsOptional } from 'class-validator';

export class UpdateMealDto {
  
  @IsString()
  public mealTitle: string;

  @IsString()
  public mealShortDescription: string;

  @IsString()
  public mealLongDescription: string;

  @IsArray()
  public mealIngredients: string[];

  @IsNumber()
  @IsOptional()
  public mealCalories: number;

  @IsNumber()
  public mealQuantity: number;

  @IsString()
  public mealQuantityUnit: string;


}
