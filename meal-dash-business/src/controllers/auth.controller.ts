import { NextFunction, Request, Response } from 'express';
import { RequestWithUser } from '@interfaces/auth.interface';
import { User } from '@interfaces/users.interface';
import AuthService from '@services/auth.service';
import { LoginUserDto } from '@/dtos/loginuser.dto';
import { CreateUserDto } from '@/dtos/createusers.dto';
import { VerifyUserDto } from '@/dtos/verifyuser.dto';
import { UpdateRadiusDto } from '@/dtos/radius.dto';
import { TokenNotVerifiedException } from '@/exceptions/TokenNotVerifiedException';
import { HttpException } from '@/exceptions/HttpException';
import { USER_ROLES } from '@/utils/util';

// AuthController class
class AuthController {
  public authService = new AuthService();

  //Signup method to create a new user
  public signUp = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const userData: CreateUserDto = req.body;
      const { cookie, createdUserData } = await this.authService.signup(userData);
      res.setHeader('Set-Cookie', [cookie]);
      res.status(201).json({ data: createdUserData, message: 'signup' });
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
    }
    // On HttpException add cookie header to response
    catch (error) {
      if (error instanceof TokenNotVerifiedException) {
        res.setHeader('Set-Cookie', [error.cookie]);
        next(error);
      } else {
        next(error);
      }
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
  public verifyUser = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.TEMP_ACCESS) {
        const userData: User = req.user;
        const { user_activation_code } = req.body;
        const updateUserData: User = await this.authService.verifyUser(userData, user_activation_code);
        res.setHeader('Set-Cookie', ['Authorization=; Max-age=0']);
        res.status(200).json({ data: updateUserData, message: 'User has been verified' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }

    } catch (error) {
      next(error);
    }
  };
}

export default AuthController;
