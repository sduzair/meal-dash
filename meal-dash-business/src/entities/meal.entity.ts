/* eslint-disable prettier/prettier */
import { IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Meal } from '@interfaces/meal.interface';

@Entity()
export class MealEntity extends BaseEntity implements Meal {
  @PrimaryGeneratedColumn()
  meal_id: number;

  @Column()
  @IsNotEmpty()
  vendor_id: number;

  @Column()
  @IsNotEmpty()
  mealTitle: string;

  @Column()
  @IsNotEmpty()
  mealShortDescription: string;

  @Column()
  @IsNotEmpty()
  mealLongDescription: string;

  @Column({type:"json"})
  @IsNotEmpty()
  mealIngredients: any;

  @Column()
  @IsNotEmpty()
  mealCalories: number;

  @Column()
  @IsNotEmpty()
  mealQuantity: number;

  @Column()
  @IsNotEmpty()
  mealQuantityUnit: string;

  @Column({default: Date.now()}) 
  timeStamp: string;

  @Column()
  @IsNotEmpty()
  imagePath: string;
}
