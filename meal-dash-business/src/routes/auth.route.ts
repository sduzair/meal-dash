import { Router } from 'express';
import AuthController from '@controllers/auth.controller';
import { Routes } from '@interfaces/routes.interface';
import authMiddleware from '@middlewares/auth.middleware';
import validationMiddleware from '@middlewares/validation.middleware';
import { LoginUserDto } from '@/dtos/loginuser.dto';
import { CreateUserDto } from '@/dtos/createusers.dto';
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';

// AuthRoute class to handle all the routes for authentication
class AuthRoute implements Routes {
  public path = '/';
  public router = Router();
  public authController = new AuthController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    this.router.post(`${this.path}signup`, validationMiddleware(CreateUserDto, 'body'), this.authController.signUp);
    this.router.post(`${this.path}login`, validationMiddleware(LoginUserDto, 'body'), this.authController.logIn);
    this.router.post(`${this.path}logout`, authMiddleware, this.authController.logOut);
    this.router.put(`${this.path}update-radius`, validationMiddleware(UpdateRadiusDto, 'body', true), this.authController.updateVenderRadius);
    this.router.put(`${this.path}verify-user`, authMiddleware, validationMiddleware(VerifyUserDto, 'body', true), this.authController.verifyUser);
  }
}

export default AuthRoute;
