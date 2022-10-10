import { IsNotEmpty } from 'class-validator';
import { BaseEntity, Entity, PrimaryGeneratedColumn, Column, Unique, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Vender } from '@/interfaces/vender.interface';

@Entity("venders")
export class VendersEntity extends BaseEntity implements Vender {



  @PrimaryGeneratedColumn()
  vender_id: number;

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