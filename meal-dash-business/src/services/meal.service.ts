/* eslint-disable prettier/prettier */
import { EntityRepository, Repository } from 'typeorm';
import { MealDto } from '@dtos/meal.dto';
import { MealEntity } from '@entities/meal.entity';
import { HttpException } from '@exceptions/HttpException';
import { Meal } from '@interfaces/meal.interface';
import { isEmpty } from '@utils/util';
import { UpdateMealDto } from '@/dtos/updatemeal.dto';
import { unlink } from 'fs';
const fs = require('fs');

@EntityRepository()
class MealService extends Repository<MealEntity> {
  public async createMeal(MealData: MealDto, user_id: number): Promise<Meal> {
    //TODO: (omkar) pls don't hardcode the directory path
   
    if (isEmpty(MealData)) throw new HttpException(400, 'MealData is empty');
    const createMealData: Meal = await MealEntity.create({ ...MealData, vendor_id: user_id }).save();
    return createMealData;
  }

  public async fetchAllMeal(): Promise<Meal[]> {
    const users: Meal[] = await MealEntity.find();
    return users;
  }

  public async fetchMealById(mealId: number): Promise<Meal> {
    if (isEmpty(mealId)) throw new HttpException(400, 'meal Id is empty');
    console.log('Meal -- id ---- ', mealId);
    const findUser: Meal = await MealEntity.findOne({ where: { meal_id: mealId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }

  public async updateMeal(meal_id: number, mealData: UpdateMealDto): Promise<Meal> {
    if (isEmpty(mealData)) throw new HttpException(400, "mealData is empty");

    const updateMeal: Meal = await MealEntity.findOne({ where: { meal_id: meal_id } });
    if (!updateMeal) throw new HttpException(409, "Meal doesn't exist");
    await MealEntity.update(meal_id, { ...mealData });
    const updatedMeal: Meal = await MealEntity.findOne({ where: { meal_id: meal_id } });
    return updatedMeal;
  }
  //deleteMealById delete  meal by id
  public async deleteMeal(meal_id: number): Promise<Meal> {
    if (isEmpty(meal_id)) throw new HttpException(400, "meal_id is empty");

    const findMeal: Meal = await MealEntity.findOne({ where: { meal_id: meal_id } });
    if (!findMeal) throw new HttpException(409, "Meal doesn't exist");

    await MealEntity.delete({ meal_id: meal_id });
    return findMeal;
  }

  //fetchAllMealByVender fetch meal by user id
  public async fetchAllMealsByVendor(vendor_id: number, vendor_name: string): Promise<Meal[]> {
    
    if (isEmpty(vendor_id)) throw new HttpException(400, 'meal Id is empty');
    const findMeals: Meal[] = await MealEntity.find({ where: { vendor_id: vendor_id } });
    if (!findMeals) throw new HttpException(409, `No meal data found for this vendor name: ${vendor_name}`);

    return findMeals;
  }

}


export default MealService;
