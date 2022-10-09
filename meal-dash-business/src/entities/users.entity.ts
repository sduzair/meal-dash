import { IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { User } from '@interfaces/users.interface';

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

  // @Column()
  // @UpdateDateColumn()
  // updatedAt: Date;
}
