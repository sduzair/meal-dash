import { hash } from 'bcrypt';
import { EntityRepository, Repository } from 'typeorm';
import { UserEntity } from '@entities/users.entity';
import { HttpException } from '@exceptions/HttpException';
import { User } from '@interfaces/users.interface';
import { isEmpty } from '@utils/util';
import { CreateUserDto } from '@/dtos/createusers.dto';

@EntityRepository()
class UserService extends Repository<UserEntity> {
  public async findAllUser(): Promise<User[]> {
    const users: User[] = await UserEntity.find();
    return users;
  }

  public async findUserById(userId: number): Promise<User> {
    if (isEmpty(userId)) throw new HttpException(400, "UserId is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: userId } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    return findUser;
  }

  public async createUser(userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user_email } });
    if (findUser) throw new HttpException(409, `This email ${userData.user_email} already exists`);

    const hashedPassword = await hash(userData.user_password, 10);
    const createUserData: User = await UserEntity.create({ ...userData, user_password: hashedPassword }).save();

    return createUserData;
  }

  public async updateUser(user_id: number, userData: CreateUserDto): Promise<User> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: user_id } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    const hashedPassword = await hash(userData.user_password, 10);
    await UserEntity.update(user_id, { ...userData, user_password: hashedPassword });

    const updateUser: User = await UserEntity.findOne({ where: { user_id: user_id } });
    return updateUser;
  }

  public async deleteUser(user_id: number): Promise<User> {
    if (isEmpty(user_id)) throw new HttpException(400, "user_id is empty");

    const findUser: User = await UserEntity.findOne({ where: { user_id: user_id } });
    if (!findUser) throw new HttpException(409, "User doesn't exist");

    await UserEntity.delete({ user_id: user_id });
    return findUser;
  }
}

export default UserService;
