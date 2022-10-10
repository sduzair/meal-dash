import { compare, hash } from 'bcrypt';
import { sign } from 'jsonwebtoken';
import { EntityRepository, Repository, Transaction } from 'typeorm';
import { SECRET_KEY } from '@config';
import { CreateUserDto } from '@dtos/users.dto';
import { UserEntity } from '@entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { DataStoredInToken, TokenData } from '@interfaces/auth.interface';
import { User } from '@interfaces/users.interface';
import { isEmpty } from '@utils/util';
import { LoginUserDto } from '@/dtos/loginuser.dto';
import { VenderDto } from '@/dtos/vender.dto';
import { VendersEntity } from '@/entities/venders.entity';

@EntityRepository()
class AuthService extends Repository<UserEntity> {

  @Transaction()
  public async signup2(userData: VenderDto): Promise<VendersEntity> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");
    console.log("userData: ", userData);
    const hashedPassword = await hash(userData.user.user_password, 10);
    userData.user.user_password = hashedPassword;
    const createUserData: VendersEntity = await VendersEntity.create({ ...userData }).save();

    // const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user.user_email } });
    // if (findUser) throw new HttpException(409, `This email ${userData.user.user_email} already exists`);

    // const hashedPassword = await hash(userData.user.user_password, 10);
    // const createUserData: User = await UserEntity.create({ ...userData, user_password: hashedPassword }).save();
    return createUserData;
  }

  public async signup(userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (findUser) throw new HttpException(409, `This email ${userData.user_email} already exists`);

    const hashedPassword = await hash(userData.user_password, 10);
    const createUserData: User = await UserEntity.create({ ...userData, user_password: hashedPassword }).save();
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

  public createCookie(tokenData: TokenData): string {
    return `Authorization=${tokenData.token}; HttpOnly; Max-Age=${tokenData.expiresIn};`;
  }
}

export default AuthService;
