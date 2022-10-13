import { CreateMealPlanDto } from "@/dtos/mealplan.dto";
import { MealPlanEntity } from "@/entities/mealplan.entity";
import { RequestWithUser } from "@/interfaces/auth.interface";
import { User } from "@/interfaces/users.interface";
import { MealPlanService } from "@/services/mealplan.service";
import { NextFunction, Request, Response } from "express";

// MealPlanController class handles all the requests for meal plans
export class MealPlanController {
    public mealPlanService = new MealPlanService();
  
    // Create a new meal plan
    public addMealPlan = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
      try {
        const data: CreateMealPlanDto = req.body;
        const user: User = req.user;
        data.foodvenderuser_id = user.user_id;
        const mealplan: MealPlanEntity = await this.mealPlanService.addMealPlan(data);
  
        res.status(201).json({ data: mealplan, message: 'addMealPlan' });
      } catch (error) {
        next(error);
      }
    };

}