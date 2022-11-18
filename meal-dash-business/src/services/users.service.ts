import { hash } from 'bcrypt';
import { EntityRepository, Repository } from 'typeorm';
import { UserEntity } from '@entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { User } from '@interfaces/users.interface';
import { isEmpty } from '@utils/util';
import { CreateUserDto } from '@/dtos/createusers.dto';
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';

// UserService class to handle all the database operations for Users
@EntityRepository()
class UserService extends Repository<UserEntity> {
  //find all users
  public async findAllUser(): Promise<User[]> {
    const users: User[] = await UserEntity.find();
    return users;
  }

  //findUserById find user by id
  public async findUserById(userId: number): Promise<User> {
    if (isEmpty(userId)) throw new HttpException(400, "UserId is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }

  //findUserByEmail find user by email
  public async createUser(userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (findUser) throw new HttpException(409, `This email ${userData.user_email} already exists`);

    const hashedPassword = await hash(userData.user_password, 10);
    const createUserData: User = await UserEntity.create({ ...userData, user_password: hashedPassword }).save();

    return createUserData;
  }
  //updateUser update user by id
  public async updateUser(user_id: number, userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: user_id } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    const hashedPassword = await hash(userData.user_password, 10);
    await UserEntity.update(user_id, { ...userData, user_password: hashedPassword });

    const updateUser: User = await UserEntity.findOne({ where: { user_id: user_id } });
    return updateUser;
  }

  //findUserByEmail find user by email
  public async deleteUser(user_id: number): Promise<User> {
    if (isEmpty(user_id)) throw new HttpException(400, "user_id is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: user_id } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await UserEntity.delete({ user_id: user_id });
    return findUser;
  }


  //updateUser update user by id
  public async updateVenderRadius(updateRadiusDto: UpdateRadiusDto): Promise<User> {
    if (isEmpty(updateRadiusDto)) throw new HttpException(400, "updateRadiusDto is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: updateRadiusDto.user_id, user_login: updateRadiusDto.user_login} });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await UserEntity.update(findUser.user_id, { vender_radius: updateRadiusDto.vender_radius });

    const updateUser: User = await UserEntity.findOne({ where: { user_id: findUser.user_id } });//TODO change interface to user
    return updateUser;
  }

  //updateUser update user by id
  public async verifyUser(verifyUserDto: VerifyUserDto): Promise<User> {
    if (isEmpty(verifyUserDto)) throw new HttpException(400, "verifyUserDto is empty");

    const user_found: User = await UserEntity.findOne({ where: { user_id: verifyUserDto.user_id, user_login: verifyUserDto.user_login} });
    if (!user_found) throw new HttpException(409, "User doesn't exist");
    if(user_found.user_activation_code != verifyUserDto.user_activation_code) throw new HttpException(409, "User activation code is not correct");

    await UserEntity.update(user_found.user_id, { user_status: true });

    const updateUser: User = await UserEntity.findOne({ where: { user_id: user_found.user_id } });//TODO change interface to user
    return updateUser;
  }
}

export default UserService;
