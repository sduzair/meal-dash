import { IsEmail, IsPhoneNumber, IsPostalCode, IsString } from 'class-validator';

//CreateUserDto class to validate the request body
export class CreateUserDto {

  @IsString()
  public user_login: string;

  @IsEmail()
  public user_email: string;

  @IsString()
  public user_password: string;

  @IsString()
  public user_type: string;

  @IsString()
  public first_name: string;

  @IsString()
  public last_name: string;

  @IsPhoneNumber()
  public phone: string;

  @IsString()
  public address1: string;

  @IsString()
  public address2: string;

  @IsString()
  public city: string;

  @IsString()
  public state: string;

  @IsPostalCode( 'CA' )
  public postal: string;

}
