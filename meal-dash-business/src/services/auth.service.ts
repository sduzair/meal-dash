/* eslint-disable prettier/prettier */
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
import { VenderDto } from '@/dtos/vender.dto';
import { CreateUserDto } from '@/dtos/createusers.dto';
import MailService from '@/helper/email.helper';
import { GOOGLE_API_KEY } from '@config';
import { createClient } from "@google/maps";
const googleMapsClient = createClient({
  key: GOOGLE_API_KEY,
  Promise: Promise
})
// AuthRepository class to handle all the database operations for authentication
@EntityRepository()
class AuthService extends Repository<UserEntity> {

  public async signup(userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");
    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (findUser) throw new HttpException(409, `This email ${userData.user_email} already exists`);

    const location = await this.getLatLng(userData);
    const hashedPassword = await hash(userData.user_password, 10);
    const createUserData: User = await UserEntity.create({ ...userData, user_password: hashedPassword, ...location }).save();
    MailService.getInstance().sendMail(createUserData);
    return createUserData;
  }

  public async login(userData: LoginUserDto): Promise<{ cookie: string; findUser: User }> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (!findUser) throw new HttpException(409, `This email ${userData.user_email} was not found`);

    const isPasswordMatching: boolean = await compare(userData.user_password, findUser.user_password);
    if (!isPasswordMatching) throw new HttpException(409, "Password not matching");

    const tokenData = this.createToken(findUser);
    const cookie = this.createCookie(tokenData);

    findUser.user_password = undefined;
    return { cookie, findUser };
  }

  public async logout(userData: User): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email, user_password: userData.user_password } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    findUser.user_password = undefined;
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
}

export default AuthService;
