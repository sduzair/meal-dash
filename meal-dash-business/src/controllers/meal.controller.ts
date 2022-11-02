import { NextFunction, Request, Response } from 'express';
import { MealDto } from '@/dtos/meal.dto';
import { Meal } from '@interfaces/meal.interface';
import MealService from '@/services/meal.service';

class MealController {
  public mealService = new MealService();

  public createMealPlan = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const mealData: MealDto = req.body;
      const createMealData: Meal = await this.mealService.createMeal(mealData);
      res.status(201).json({ data: createMealData, message: 'created' });
    } catch (error) {
      next(error);
    }
  };

  public fetchMeals = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const ftechAllMealsData: Meal[] = await this.mealService.fetchAllMeal();

      res.status(200).json({ data: ftechAllMealsData, message: 'findAll' });
    } catch (error) {
      next(error);
    }
  };

  public fetchMealById = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const mealId = Number(req.params.id);
      const findOneMealData: Meal = await this.mealService.fetchMealById(mealId);
      res.status(200).json({ data: findOneMealData, message: 'findOne' });
    } catch (error) {
      next(error);
    }
  };
}

export default MealController;
