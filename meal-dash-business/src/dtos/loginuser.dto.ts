import { IsEmail, IsString } from 'class-validator';

//LoginUserDto class to validate the request body
export class LoginUserDto {


  @IsEmail()
  public user_email: string;

  @IsString()
  public user_password: string;
}
