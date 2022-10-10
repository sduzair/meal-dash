import { IsEmail, IsString } from 'class-validator';

export class LoginUserDto {


  @IsEmail()
  public user_email: string;

  @IsString()
  public user_password: string;
}
