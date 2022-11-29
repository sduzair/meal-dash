import { NextFunction, Request, Response } from 'express';
import { User } from '@interfaces/users.interface';
import userService from '@services/users.service';
import { CreateUserDto } from '@/dtos/createusers.dto';
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';
import { RequestWithUser } from '@/interfaces/auth.interface';
import { HttpException } from '@/exceptions/HttpException';
import { USER_ROLES } from '@/utils/util';

// UserController class
class UsersController {
  public userService = new userService();

  //getUsers method to get all users
  public getUsers = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const findAllUsersData: User[] = await this.userService.findAllUser();

        res.status(200).json({ data: findAllUsersData, message: 'findAll' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  //getUserById method to get a user by id
  public getUserById = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const userId = Number(req.params.user_id);
        const findOneUserData: User = await this.userService.findUserById(userId);

        res.status(200).json({ data: findOneUserData, message: 'findOne' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  //createUser method to create a new user
  public createUser = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const userData: CreateUserDto = req.body;
        const createUserData: User = await this.userService.createUser(userData);

        res.status(201).json({ data: createUserData, message: 'created' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  //updateUser method to update a user by id
  public updateUser = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const userId = Number(req.params.user_id);
        const userData: CreateUserDto = req.body;
        const updateUserData: User = await this.userService.updateUser(userId, userData);

        res.status(200).json({ data: updateUserData, message: 'updated' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  //deleteUser method to delete a user by id
  public deleteUser = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const userId = Number(req.params.user_id);
        const deleteUserData: User = await this.userService.deleteUser(userId);
        res.status(200).json({ data: deleteUserData, message: 'User has been deleted' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  //updateVenderRadius method to update a user by id
  public updateVenderRadius = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const userData: UpdateRadiusDto = req.body;
        const updateUserData: User = await this.userService.updateVenderRadius(userData);

        res.status(200).json({ data: updateUserData, message: 'Vender delivery radius has been updated' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };

  //updateVenderRadius method to update a user by id
  public verifyUser = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const userData: VerifyUserDto = req.body;
        const updateUserData: User = await this.userService.verifyUser(userData);

        res.status(200).json({ data: updateUserData, message: 'User has been verified' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };
}

export default UsersController;
