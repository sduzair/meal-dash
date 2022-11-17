/* eslint-disable prettier/prettier */
import { IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn, Double } from 'typeorm';
import { User } from '@interfaces/users.interface';

//MealPlanEntity represents the mealplan table in the database
@Entity("users")
export class UserEntity extends BaseEntity implements User {
  @PrimaryGeneratedColumn()
  user_id: number;

  @Column()
  @IsNotEmpty()
  @Unique(['user_login'])
  user_login: string;

  @Column()
  @IsNotEmpty()
  @Unique(['user_email'])
  user_email: string;

  @Column()
  @IsNotEmpty()
  user_password: string;

  @Column()
  @CreateDateColumn()
  created_date: Date;

  @Column()
  @IsNotEmpty()
  phone: string;

  @Column()
  @IsNotEmpty()
  user_type: string;

  @Column()
  @IsNotEmpty()
  address1: string;

  @Column()
  @IsNotEmpty()
  address2: string;

  @Column()
  @IsNotEmpty()
  city: string;

  @Column()
  @IsNotEmpty()
  state: string;

  @Column()
  @IsNotEmpty()
  postal: string;

  @Column("double")
  @IsNotEmpty()
  lat: number;

  @Column("double")
  @IsNotEmpty()
  lng: number;

  @Column()
  @IsNotEmpty()
  formattedAddress: string;

}
