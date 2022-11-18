import { IsEmail, IsNumber, IsPhoneNumber, IsPostalCode, IsString } from 'class-validator';

//UpdateRadiusDto class to validate the request body
export class UpdateRadiusDto {

    @IsNumber()
    public user_id: number;

    @IsString()
    public user_login: string;

    @IsNumber()
    public vender_radius: number;
}
