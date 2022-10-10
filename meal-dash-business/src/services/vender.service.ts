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
class VenderService extends Repository<VendersEntity> {

  @Transaction()
  public async addVender(userData: VenderDto): Promise<VendersEntity> {
    if (isEmpty(userData)) throw new HttpException(400, "userData is empty");
    console.log("userDataserve: ", userData);
    const hashedPassword = await hash(userData.user.user_password, 10);
    userData.user.user_password = hashedPassword;
    const createUserData: VendersEntity = await VendersEntity.create(userData).save();

    // const findUser: User = await UserEntity.findOne({ where: { user_email: userData.user.user_email } });
    // if (findUser) throw new HttpException(409, `This email ${userData.user.user_email} already exists`);

    // const hashedPassword = await hash(userData.user.user_password, 10);
    // const createUserData: User = await UserEntity.create({ ...userData, user_password: hashedPassword }).save();
    return createUserData;
  }
}

export default VenderService;