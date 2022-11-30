/* eslint-disable prettier/prettier */
import { NextFunction, Request, Response } from 'express';
import { MealDto } from '@/dtos/meal.dto';
import { Meal } from '@interfaces/meal.interface';
import MealService from '@/services/meal.service';
import { RequestWithUser, RequestWithUserAndFile } from '@/interfaces/auth.interface';
import { plainToInstance } from 'class-transformer';
import { UpdateMealDto } from '@/dtos/updatemeal.dto';
import { HttpException } from '@/exceptions/HttpException';
import { UPLOAD_PATH } from '@/config';
import { USER_ROLES } from '@/utils/util';

class MealController {
  public mealService = new MealService();

  public createMealPlan = async (req: RequestWithUserAndFile, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const mealData = plainToInstance(MealDto, JSON.parse(req.fields.mealdata));
        mealData.imagePath = req.files.image.path.replace(UPLOAD_PATH, '');
        var parts = req.files.image.path.replace(UPLOAD_PATH, '').split("/");
        mealData.imagePath = parts[parts.length - 1]; 
        const user = req.user;
        const createMealData: Meal = await this.mealService.createMeal(mealData, user.user_id);
        res.status(201).json({ data: createMealData, message: 'created' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  public fetchMeals = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const ftechAllMealsData: Meal[] = await this.mealService.fetchAllMeal();
        res.status(200).json({ data: ftechAllMealsData, message: 'findAll' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  public fetchMealById = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const mealId = Number(req.params.id);
        const findOneMealData: Meal = await this.mealService.fetchMealById(mealId);
        res.status(200).json({ data: findOneMealData, message: 'findOne' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };


  public updateMeal = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const meal_id = Number(req.params.meal_id);
        const mealData: UpdateMealDto = req.body;
        const updateUserData: Meal = await this.mealService.updateMeal(meal_id, mealData);

        res.status(200).json({ data: updateUserData, message: 'updated' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  public deleteMeal = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const mealId = Number(req.params.meal_id);
        const deleteMealData: Meal = await this.mealService.deleteMeal(mealId);

        res.status(200).json({ data: deleteMealData, message: 'meal deleted' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  public fetchAllMealsByVendor = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const user = req.user;
        const vendorId = user.user_id;
        const vendorName = user.user_login;
        const findAllMeals: Meal[] = await this.mealService.fetchAllMealsByVendor(vendorId, vendorName);
        res.status(200).json({ data: findAllMeals, message: 'findAll' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

}

export default MealController;
