import { IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Subscription } from '@interfaces/subscription.interface';

@Entity()
export class SubscriptionEntity extends BaseEntity implements Subscription {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  @IsNotEmpty()
  ends_at: string;

  @Column()
  @IsNotEmpty()
  starts_at: string;

  @Column()
  @CreateDateColumn()
  created_at: string;

  @Column()
  @UpdateDateColumn()
  deleted_at: string;

  @Column()
  is_deleted: boolean;

  @Column()
  mealplan_id: number;
}
