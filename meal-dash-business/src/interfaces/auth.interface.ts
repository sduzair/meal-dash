import { Request } from 'express';
import { User } from '@interfaces/users.interface';

export interface DataStoredInToken {
  user_id: number;
}

export interface TokenData {
  token: string;
  expiresIn: number;
}

export interface RequestWithUser extends Request {
  user: User;
}

export interface RequestWithUserAndFile extends Request {
  user: User;
  files: any;
  fields: any;
}
