import { Router } from 'express';
import MealController from '@controllers/meal.controller';
import { MealDto } from '@/dtos/meal.dto';
import { Routes } from '@interfaces/routes.interface';
import validationMiddleware from '@middlewares/validation.middleware';
import upload from '@middlewares/upload.middleware';
import authMiddleware from '@/middlewares/auth.middleware';

class MealRoute implements Routes {
  public path = '/meal';
  public router = Router();
  public mealController = new MealController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    //this.router.post(`${this.path}`, validationMiddleware(MealDto, 'body'), this.mealController.createMealPlan);
    this.router.post(`${this.path}`, upload.single('image'), this.mealController.createMealPlan);
    this.router.get(`${this.path}`, this.mealController.fetchMeals);
    this.router.get(`${this.path}/:id(\\d+)`, this.mealController.fetchMealById);
    this.router.put(`${this.path}/:meal_id(\\d+)`, this.mealController.updateMeal);
    this.router.delete(`${this.path}/:meal_id(\\d+)`, this.mealController.deleteMeal);
    this.router.get(`${this.path}/all`, authMiddleware, this.mealController.fetchAllMealsByVendor);
  }
}

export default MealRoute;
