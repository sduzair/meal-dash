import { CreateMealPlanDto } from "@/dtos/mealplan.dto";
import { MealPlanEntity } from "@/entities/mealplan.entity";
import { HttpException } from "@/exceptions/HttpException";
import { User } from "@/interfaces/users.interface";
import { isEmpty } from "class-validator";
import { EntityRepository, Repository } from "typeorm";

@EntityRepository()
export class MealPlanService extends Repository<MealPlanEntity> {

    public async addMealPlan(data: CreateMealPlanDto): Promise<MealPlanEntity> {
        if (isEmpty(data)) throw new HttpException(400, "meal plan is empty");

        const mealplan: MealPlanEntity = await MealPlanEntity.findOne({ where: { foodvenderuser_id: data.foodvenderuser_id, mealplan_title: data.mealplan_title } });
        if (mealplan) throw new HttpException(409, `This meal plan ${data.mealplan_title} already exists`);

        const createUserData: MealPlanEntity = await MealPlanEntity.create({ ...data }).save();
        return createUserData;
    }
}