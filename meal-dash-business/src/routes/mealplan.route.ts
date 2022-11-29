import { MealPlanController } from "@/controllers/mealplan.controller";
import { CreateMealPlanDto } from "@/dtos/mealplan.dto";
import { Routes } from "@/interfaces/routes.interface";
import authMiddleware from "@/middlewares/auth.middleware";
import validationMiddleware from "@/middlewares/validation.middleware";
import { Router } from "express";

// MealPlanRoute class to handle all the routes for meal plans
export default class MealPlanRoute implements Routes {
    public path = '/mealplans';
    public router = Router();
    public mealplanController = new MealPlanController();

    constructor() {
        this.initializeRoutes();
    }

    private initializeRoutes() {
        this.router.get(`${this.path}`, authMiddleware, this.mealplanController.getMealPlans);

        this.router.post(`${this.path}/add`, authMiddleware, validationMiddleware(CreateMealPlanDto, 'body'), 
        this.mealplanController.addMealPlan);
    }
}