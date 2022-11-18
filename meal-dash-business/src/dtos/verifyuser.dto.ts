import { IsEmail, IsNumber, IsPhoneNumber, IsPostalCode, IsString } from 'class-validator';

//UpdateRadiusDto class to validate the request body
export class VerifyUserDto {

    @IsNumber()
    public user_id: number;

    @IsString()
    public user_login: string;

    @IsNumber()
    public user_activation_code: number;
}
