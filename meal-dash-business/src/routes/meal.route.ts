/* eslint-disable prettier/prettier */
import { NextFunction, Request, Response, Router } from 'express';
import MealController from '@controllers/meal.controller';
import { MealDto } from '@/dtos/meal.dto';
import { Routes } from '@interfaces/routes.interface';
import validationMiddleware from '@middlewares/validation.middleware';
import upload from '@middlewares/upload.middleware';
import authMiddleware from '@/middlewares/auth.middleware';
import { HttpException } from '@/exceptions/HttpException';
import { logger } from '@/utils/logger';
import { json } from 'envalid';
import convertToJson from '@/middlewares/convert.middleware';
import validationFileUploadMiddleware from '@/middlewares/mealfileuploadvalidation.middleware';

class MealRoute implements Routes {
  public path = '/meal';
  public router = Router();
  public mealController = new MealController();

  constructor() {
    this.initializeRoutes();
  }

  
  private initializeRoutes() {
    this.router.post(`${this.path}/add-meal`, authMiddleware, validationFileUploadMiddleware(MealDto, 'fields'), this.mealController.createMealPlan);
    this.router.get(`${this.path}`, authMiddleware, this.mealController.fetchMeals);
    this.router.get(`${this.path}/:id(\\d+)`, authMiddleware, this.mealController.fetchMealById);
    this.router.put(`${this.path}/:meal_id(\\d+)`, authMiddleware, this.mealController.updateMeal);
    this.router.delete(`${this.path}/:meal_id(\\d+)`, authMiddleware, this.mealController.deleteMeal);
    this.router.get(`${this.path}/all`, authMiddleware, this.mealController.fetchAllMealsByVendor);
  }
}

export default MealRoute;
