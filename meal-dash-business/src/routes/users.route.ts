import { Router } from 'express';
import UsersController from '@controllers/users.controller';
import { Routes } from '@interfaces/routes.interface';
import validationMiddleware from '@middlewares/validation.middleware';
import { CreateUserDto } from '@/dtos/createusers.dto';
import authMiddleware from '@/middlewares/auth.middleware';
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';

// UsersRoute class to handle all the routes for users
class UsersRoute implements Routes {
  public path = '/users';
  public router = Router();
  public usersController = new UsersController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    this.router.get(`${this.path}`, authMiddleware, this.usersController.getUsers);
    this.router.get(`${this.path}/:user_id(\\d+)`, authMiddleware, this.usersController.getUserById);
    this.router.post(`${this.path}`, authMiddleware, validationMiddleware(CreateUserDto, 'body'), this.usersController.createUser);
    this.router.put(`${this.path}/:user_id(\\d+)`, authMiddleware, validationMiddleware(CreateUserDto, 'body', true), this.usersController.updateUser);
    this.router.delete(`${this.path}/:user_id(\\d+)`, authMiddleware, this.usersController.deleteUser);
    this.router.put(`${this.path}/update-radius`, validationMiddleware(UpdateRadiusDto, 'body', true), this.usersController.updateVenderRadius);
    this.router.put(`${this.path}/verify-user`, validationMiddleware(VerifyUserDto, 'body', true), this.usersController.verifyUser);
  }
}

export default UsersRoute;
