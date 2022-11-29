import { MealDto } from "@/dtos/meal.dto";
import { CreateMealPlanDto } from "@/dtos/mealplan.dto";
import { MealPlanFullDto } from "@/dtos/mealplanfull.dto";
import { MealEntity } from "@/entities/meal.entity";
import { MealPlanEntity } from "@/entities/mealplan.entity";
import { HttpException } from "@/exceptions/HttpException";
import { isEmpty } from "class-validator";
import { EntityRepository, Repository } from "typeorm";


// MealPlanRepository class to handle all the database operations for meal plans
@EntityRepository()
export class MealPlanService extends Repository<MealPlanEntity> {


    // get all meal plans by foodvenderuser_id
    public async getMealPlansByFoodVenderUserId(foodvenderuser_id: number): Promise<MealPlanFullDto[]> {
        const mealPlanEntities: MealPlanEntity[] = await MealPlanEntity.find({ where: { foodvenderuser_id: foodvenderuser_id } });
        const mealPlanFullDtos: MealPlanFullDto[] = [];
        for (const mealPlanEntity of mealPlanEntities) {
            mealPlanFullDtos.push(await this.getCommonMealPlanDto(mealPlanEntity));
        }
        return mealPlanFullDtos;
    }

    // Create a new meal plan
    public async addMealPlan(data: CreateMealPlanDto, foodvenderuser_id: number): Promise<MealPlanFullDto> {
        if (isEmpty(data)) throw new HttpException(400, "meal plan is empty");

        const mealplan: MealPlanEntity = await MealPlanEntity.findOne({ where: { foodvenderuser_id: foodvenderuser_id, mealplan_title: data.mealplan_title } });
        if (mealplan) throw new HttpException(409, `This meal plan ${data.mealplan_title} already exists`);

        const mealPlanEntity: MealPlanEntity = await MealPlanEntity.create({ ...data, foodvenderuser_id: foodvenderuser_id }).save();
        
        return this.getCommonMealPlanDto(mealPlanEntity);
    }

    // Map meals to meal ids and return meal plan dto
    public async getCommonMealPlanDto(mealPlanEntity: MealPlanEntity): Promise<MealPlanFullDto> {
        const { ...mealPlanFull} : MealPlanFullDto = mealPlanEntity
        if(mealPlanEntity.meal_ids){
            const mealIds: number[] = mealPlanEntity.meal_ids;
            let mealsEntities: MealEntity[] = await MealEntity.findByIds(mealIds);
            let mealsDtos : MealDto[] = [];
            for (const mealEntity of mealsEntities) {
                mealsDtos.push({...mealEntity});
            }

            mealPlanFull.meals = mealsDtos;
        }
        return mealPlanFull;
    }
}