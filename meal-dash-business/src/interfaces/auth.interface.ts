import { Request } from 'express';
import { User } from '@interfaces/users.interface';

export interface DataStoredInToken {
  user_id: number;
  user_role: string;
}

export interface TokenData {
  token: string;
  expiresIn: number;
}

export interface RequestWithUser extends Request {
  user: User;
  user_role: string;
}

export interface RequestWithUserAndFile extends Request {
  user: User;
  user_role: string;
  files: any;
  fields: any;
}
