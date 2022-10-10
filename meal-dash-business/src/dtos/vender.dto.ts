import { IsEmail, IsObject, IsPhoneNumber, IsString } from 'class-validator';
import { CreateUserDto } from './users.dto';

export class VenderDto {

  @IsObject()
  public user: CreateUserDto;

  @IsString()
  public vender_name: string;

  @IsPhoneNumber()
  public vender_phone: string;
}
