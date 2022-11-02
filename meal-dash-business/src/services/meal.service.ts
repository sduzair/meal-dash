import { EntityRepository, Repository } from 'typeorm';
import { MealDto } from '@dtos/meal.dto';
import { MealEntity } from '@entities/meal.entity';
import { HttpException } from '@exceptions/HttpException';
import { Meal } from '@interfaces/meal.interface';
import { isEmpty } from '@utils/util';

@EntityRepository()
class MealService extends Repository<MealEntity> {
  public async createMeal(MealData: MealDto): Promise<Meal> {
    if (isEmpty(MealData)) throw new HttpException(400, 'MealData is empty');
    const createMealData: Meal = await MealEntity.create({ ...MealData }).save();
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
}

export default MealService;
