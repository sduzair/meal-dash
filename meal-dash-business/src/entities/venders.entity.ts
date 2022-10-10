import { IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn, OneToOne, JoinColumn } from 'typeorm';
import { Vender } from '@/interfaces/vender.interface';
import { UserEntity } from './users.entity';

@Entity("venders")
export class VendersEntity extends BaseEntity implements Vender {

  @PrimaryGeneratedColumn()
  vender_id: number;

  @OneToOne(type => UserEntity, user => user.user_id )
  @JoinColumn({ name: "user_id" })
  user: UserEntity;

  @Column()
  @IsNotEmpty()
  @Unique(['vender_name'])
  public vender_name: string;

  @Column()
  @IsNotEmpty()
  vender_phone: string;

  @Column()
  @IsNotEmpty()
  vender_city: string;

  @Column()
  @IsNotEmpty()
  vender_state: string;

  @Column()
  @IsNotEmpty()
  vender_postal: string;

  // @Column()
  // @UpdateDateColumn()
  // updatedAt: Date;
}