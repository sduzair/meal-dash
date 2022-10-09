import { IsEmail, IsString } from 'class-validator';

export class CreateUserDto {

  @IsString()
  public user_login: string;

  @IsEmail()
  public user_email: string;

  @IsString()
  public user_password: string;
}
