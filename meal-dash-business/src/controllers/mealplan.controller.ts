import { CreateMealPlanDto } from "@/dtos/mealplan.dto";
import { MealPlanFullDto } from "@/dtos/mealplanfull.dto";
import { MealPlanEntity } from "@/entities/mealplan.entity";
import { HttpException } from "@/exceptions/HttpException";
import { RequestWithUser } from "@/interfaces/auth.interface";
import { User } from "@/interfaces/users.interface";
import { MealPlanService } from "@/services/mealplan.service";
import { USER_ROLES } from "@/utils/util";
import { NextFunction, Request, Response } from "express";

// MealPlanController class handles all the requests for meal plans
export class MealPlanController {
  public mealPlanService = new MealPlanService();


  // Get all meal plans by foodvenderuser_id
  public getMealPlans = async (req: RequestWithUser, res: Response, next: NextFunction) => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const user = req.user;
        const foodvenderuser_id: number = req.user.user_id;
        const mealPlanFullDtos: MealPlanFullDto[] = await this.mealPlanService.getMealPlansByFoodVenderUserId(foodvenderuser_id);
        res.status(200).json({ data: mealPlanFullDtos, message: "meal plans" });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  // Create a new meal plan
  public addMealPlan = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const data: CreateMealPlanDto = req.body;
        const user: User = req.user;
        const mealplan: MealPlanFullDto = await this.mealPlanService.addMealPlan(data, user.user_id);

        res.status(201).json({ data: mealplan, message: 'addMealPlan' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

}