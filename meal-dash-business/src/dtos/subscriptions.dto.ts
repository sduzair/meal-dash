import { IsBoolean, IsNumber, IsString } from 'class-validator';

export class SubscriptionDto {
  @IsString()
  public starts_at: string;

  @IsString()
  public ends_at: string;

  @IsString()
  public created_at: string;

  @IsString()
  public deleted_at: string;

  @IsBoolean()
  public is_deleted: boolean;

  @IsNumber()
  public mealplan_id: number;
}
