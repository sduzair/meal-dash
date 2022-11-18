import { NextFunction, Request, Response } from 'express';
import { User } from '@interfaces/users.interface';
import userService from '@services/users.service';
import { CreateUserDto } from '@/dtos/createusers.dto';
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';

// UserController class
class UsersController {
  public userService = new userService();

  //getUsers method to get all users
  public getUsers = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const findAllUsersData: User[] = await this.userService.findAllUser();

      res.status(200).json({ data: findAllUsersData, message: 'findAll' });
    } catch (error) {
      next(error);
    }
  };

  //getUserById method to get a user by id
  public getUserById = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userId = Number(req.params.user_id);
      const findOneUserData: User = await this.userService.findUserById(userId);

      res.status(200).json({ data: findOneUserData, message: 'findOne' });
    } catch (error) {
      next(error);
    }
  };

  //createUser method to create a new user
  public createUser = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: CreateUserDto = req.body;
      const createUserData: User = await this.userService.createUser(userData);

      res.status(201).json({ data: createUserData, message: 'created' });
    } catch (error) {
      next(error);
    }
  };

  //updateUser method to update a user by id
  public updateUser = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userId = Number(req.params.user_id);
      const userData: CreateUserDto = req.body;
      const updateUserData: User = await this.userService.updateUser(userId, userData);

      res.status(200).json({ data: updateUserData, message: 'updated' });
    } catch (error) {
      next(error);
    }
  };

  //deleteUser method to delete a user by id
  public deleteUser = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userId = Number(req.params.user_id);
      const deleteUserData: User = await this.userService.deleteUser(userId);
      res.status(200).json({ data: deleteUserData, message: 'User has been deleted' });
    } catch (error) {
      next(error);
    }
  };

  //updateVenderRadius method to update a user by id
  public updateVenderRadius = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: UpdateRadiusDto = req.body;
      const updateUserData: User = await this.userService.updateVenderRadius(userData);

      res.status(200).json({ data: updateUserData, message: 'Vender delivery radius has been updated' });
    } catch (error) {
      next(error);
    }
  };

  //updateVenderRadius method to update a user by id
  public verifyUser = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: VerifyUserDto = req.body;
      const updateUserData: User = await this.userService.verifyUser(userData);

      res.status(200).json({ data: updateUserData, message: 'User has been verified' });
    } catch (error) {
      next(error);
    }
  };
}

export default UsersController;
