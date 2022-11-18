import { NextFunction, Request, Response } from 'express';
import { RequestWithUser } from '@interfaces/auth.interface';
import { User } from '@interfaces/users.interface';
import AuthService from '@services/auth.service';
import { LoginUserDto } from '@/dtos/loginuser.dto';
import { CreateUserDto } from '@/dtos/createusers.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';
import { UpdateRadiusDto } from '@/dtos/radius.dto';

// AuthController class
class AuthController {
  public authService = new AuthService();

  //Signup method to create a new user
  public signUp = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: CreateUserDto = req.body;
      const signUpUserData: User = await this.authService.signup(userData);

      res.status(201).json({ data: signUpUserData, message: 'signup' });
    } catch (error) {
      next(error);
    }
  };

  //Login method to login a user
  public logIn = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: LoginUserDto = req.body;
      const { cookie, findUser } = await this.authService.login(userData);

      res.setHeader('Set-Cookie', [cookie]);
      res.status(200).json({ data: findUser, message: 'login' });
    } catch (error) {
      next(error);
    }
  };

  //Logout method to logout a user
  public logOut = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: User = req.user;
      const logOutUserData: User = await this.authService.logout(userData);

      res.setHeader('Set-Cookie', ['Authorization=; Max-age=0']);
      res.status(200).json({ data: logOutUserData, message: 'logout' });
    } catch (error) {
      next(error);
    }
  };

  //updateVenderRadius method to update a user by id
  public updateVenderRadius = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: UpdateRadiusDto = req.body;
      const updateUserData: User = await this.authService.updateVenderRadius(userData);

      res.status(200).json({ data: updateUserData, message: 'Vender delivery radius has been updated' });
    } catch (error) {
      next(error);
    }
  };

  //updateVenderRadius method to update a user by id
  public verifyUser = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: VerifyUserDto = req.body;
      const updateUserData: User = await this.authService.verifyUser(userData);

      res.status(200).json({ data: updateUserData, message: 'User has been verified' });
    } catch (error) {
      next(error);
    }
  };
}

export default AuthController;
