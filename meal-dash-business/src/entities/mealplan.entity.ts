import { IsNotEmpty } from "class-validator";
import { Entity, BaseEntity, PrimaryGeneratedColumn, Column, Unique } from "typeorm";

//MealPlanEntity represents the mealplan table in the database
@Entity("mealplans")
export class MealPlanEntity extends BaseEntity{
  @PrimaryGeneratedColumn()
  mealplan_id: number;

  @Column()
  foodvenderuser_id: number;

  @Column()
  @IsNotEmpty()
  mealplan_recurrence: string;

  @Column()
  @IsNotEmpty()
  @Unique(['foodvenderuser_id','mealplan_title'])
  mealplan_title: string;

  @Column()
  @IsNotEmpty()
  mealplan_description: string;

  @Column()
  @IsNotEmpty()
  is_active: boolean;

}