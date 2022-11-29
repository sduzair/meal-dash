import { compare, hash } from 'bcrypt';
import { sign } from 'jsonwebtoken';
import { EntityRepository, Repository, Transaction } from 'typeorm';
import { SECRET_KEY } from '@config';
import { UserEntity } from '@entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { DataStoredInToken, TokenData } from '@interfaces/auth.interface';
import { User } from '@interfaces/users.interface';
import { isEmpty } from '@utils/util';
import { LoginUserDto } from '@/dtos/loginuser.dto';
import { CreateUserDto } from '@/dtos/createusers.dto';
import MailService from '@/helper/email.helper';
import { GOOGLE_API_KEY } from '@config';
import { createClient } from "@google/maps";
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { TokenNotVerifiedException } from '@/exceptions/TokenNotVerifiedException';
const googleMapsClient = createClient({
  key: GOOGLE_API_KEY,
  Promise: Promise
})
// AuthRepository class to handle all the database operations for authentication
@EntityRepository()
class AuthService extends Repository<UserEntity> {

  public async signup(userData: CreateUserDto): Promise<{ cookie: string; createdUserData: User }> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");
    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (findUser) throw new HttpException(409, `This email ${userData.user_email} already exists`);

    const location = await this.getLatLng(userData);
    const hashedPassword = await hash(userData.user_password, 10);
    let security_code = Math.floor(100000 + Math.random() * 900000);
    const createdUserData: User = await UserEntity.create({ ...userData, user_activation_code: security_code, user_password: hashedPassword, ...location }).save();
    MailService.getInstance().sendMail(createdUserData);
    const tokenData = this.createToken(createdUserData);
    const cookie = this.createCookie(tokenData);
    createdUserData.user_password = undefined;
    createdUserData.user_activation_code= undefined;
    return { cookie, createdUserData };
  }

  public async login(userData: LoginUserDto): Promise<{ cookie: string; findUser: User }> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (!findUser) throw new HttpException(409, `This email ${userData.user_email} was not found`);

    if(!findUser.user_status){
      //Setting up the temprory token
      const tokenData = this.createToken(findUser);
      const cookie = this.createCookie(tokenData);
      throw new TokenNotVerifiedException(403, `This email ${userData.user_email} is not verified`, cookie);
    } 

    const isPasswordMatching: boolean = await compare(userData.user_password, findUser.user_password);
    if (!isPasswordMatching) throw new HttpException(409, "Password not matching");

    const tokenData = this.createToken(findUser);
    const cookie = this.createCookie(tokenData);

    findUser.user_password = undefined;
    findUser.user_activation_code= undefined;
    return { cookie, findUser };
  }

  public async logout(userData: User): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email, user_password: userData.user_password } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    findUser.user_password = undefined;
    findUser.user_activation_code= undefined;
    return findUser;
  }

  public createToken(user: User): TokenData {
    const dataStoredInToken: DataStoredInToken = { user_id: user.user_id };
    const secretKey: string = SECRET_KEY;
    const expiresIn: number = 60 * 60;

    return { expiresIn, token: sign(dataStoredInToken, secretKey, { expiresIn }) };
  }

  private getLatLng = (userData: CreateUserDto): Promise<{lat:number, lng: number, formattedAddress: string}> => {
    let address: string;
        address += isEmpty(userData.address1) ? "": userData.address1 +" ";
        address += isEmpty(userData.address2) ? "": userData.address2 +" ";
        address += isEmpty(userData.city) ? "": userData.city +" ";
        address += isEmpty(userData.state) ? "": userData.state +" ";
        address += isEmpty(userData.postal) ? "": userData.postal +" ";

    const location = googleMapsClient.geocode({address: address})
    .asPromise()
    .then((response) => {
      const locationData = {
        lat: response.json.results[0].geometry.location.lat,
        lng: response.json.results[0].geometry.location.lng,
        formattedAddress: response.json.results[0].formatted_address
      }
      return locationData;
    })
    .catch((err) => {
      console.log(err);
    });
    return location;
  }
  public createCookie(tokenData: TokenData): string {
    return `Authorization=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn};`;
  }


   //updateUser update user by id
   public async updateVenderRadius(updateRadiusDto: UpdateRadiusDto): Promise<User> {
    if (isEmpty(updateRadiusDto)) throw new HttpException(400, "updateRadiusDto is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: updateRadiusDto.user_id, user_login: updateRadiusDto.user_login} });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await UserEntity.update(findUser.user_id, { vender_radius: updateRadiusDto.vender_radius });

    const updateUser: User = await UserEntity.findOne({ where: { user_id: findUser.user_id } });
    updateUser.user_password = undefined;
    updateUser.user_activation_code= undefined;
    return updateUser;
  }

  //updateUser update user by id
  public async verifyUser(verifyUserDto: User, user_activation_code: number): Promise<User> {
    if (isEmpty(verifyUserDto)) throw new HttpException(400, "verifyUserDto is empty");

    const user_found: User = await UserEntity.findOne({ where: { user_id: verifyUserDto.user_id, user_login: verifyUserDto.user_login} });
    if (!user_found) throw new HttpException(409, "User doesn't exist");
    if(user_found.user_activation_code != user_activation_code) throw new HttpException(409, "User activation code is not correct");

    await UserEntity.update(user_found.user_id, { user_status: true });

    const updateUser: User = await UserEntity.findOne({ where: { user_id: user_found.user_id } });//TODO change interface to user
    updateUser.user_password = undefined;
    updateUser.user_activation_code= undefined;
    return updateUser;
  }
}

export default AuthService;
