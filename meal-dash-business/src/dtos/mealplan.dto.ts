import { IsNotEmpty } from "class-validator";

//MealPlanDto class to validate the request body
export class CreateMealPlanDto {
  
    foodvenderuser_id?: number;
  
    @IsNotEmpty()
    mealplan_recurrence: string;
  
    @IsNotEmpty()
    mealplan_title: string;
  
    @IsNotEmpty()
    mealplan_description: string;
  
    @IsNotEmpty()
    is_active: boolean;

    

}