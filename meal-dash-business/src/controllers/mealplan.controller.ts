import { CreateMealPlanDto } from "@/dtos/mealplan.dto";
import { MealPlanFullDto } from "@/dtos/mealplanfull.dto";
import { MealPlanEntity } from "@/entities/mealplan.entity";
import { RequestWithUser } from "@/interfaces/auth.interface";
import { User } from "@/interfaces/users.interface";
import { MealPlanService } from "@/services/mealplan.service";
import { NextFunction, Request, Response } from "express";

// MealPlanController class handles all the requests for meal plans
export class MealPlanController {
    public mealPlanService = new MealPlanService();


    // Get all meal plans by foodvenderuser_id
    public getMealPlans = async (req: RequestWithUser, res: Response, next: NextFunction) => {
        try {
            const foodvenderuser_id: number = req.user.user_id;
            const mealPlanFullDtos: MealPlanFullDto[] = await this.mealPlanService.getMealPlansByFoodVenderUserId(foodvenderuser_id);
            res.status(200).json({ data: mealPlanFullDtos, message: "meal plans" });
        } catch (error) {
            next(error);
        }
    };
  
    // Create a new meal plan
    public addMealPlan = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
      try {
        const data: CreateMealPlanDto = req.body;
        const user: User = req.user;
        const mealplan: MealPlanFullDto = await this.mealPlanService.addMealPlan(data, user.user_id);
  
        res.status(201).json({ data: mealplan, message: 'addMealPlan' });
      } catch (error) {
        next(error);
      }
    };

}