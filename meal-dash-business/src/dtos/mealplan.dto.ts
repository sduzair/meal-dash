import { IsArray, IsNotEmpty } from "class-validator";

//MealPlanDto class to validate the request body
export class CreateMealPlanDto {
  
  
    @IsNotEmpty()
    mealplan_recurrence: string;
  
    @IsNotEmpty()
    mealplan_title: string;
  
    @IsNotEmpty()
    mealplan_description: string;
  
    @IsNotEmpty()
    is_active: boolean;

    @IsArray()
    public meal_ids: number[] = [];
    

}