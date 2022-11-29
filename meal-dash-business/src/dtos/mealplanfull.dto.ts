import { IsNotEmpty } from "class-validator";
import { MealDto } from "./meal.dto";

//MealPlanDto class to validate the request body
export class MealPlanFullDto {
  
  
    mealplan_id: number;

    @IsNotEmpty()
    mealplan_recurrence: string;
  
    @IsNotEmpty()
    mealplan_title: string;
  
    @IsNotEmpty()
    mealplan_description: string;

    meal_ids: number[];

    meals?: MealDto[];
  
    @IsNotEmpty()
    is_active: boolean;

    
    

}