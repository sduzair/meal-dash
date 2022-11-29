import { NextFunction, Request, Response } from 'express';
import { SubscriptionDto } from '@/dtos/subscriptions.dto';
import { Subscription } from '@interfaces/subscription.interface';
import SubscriptionService from '@services/subscription.service';
import { RequestWithUser } from '@/interfaces/auth.interface';
import { USER_ROLES } from '@/utils/util';
import { HttpException } from '@/exceptions/HttpException';

class SubscriptionController {
  public subscriptionService = new SubscriptionService();

  public createSubscriptionPlan = async (req: RequestWithUser, res: Response, next: NextFunction): Promise<void> => {
    try {
      if (req.user_role && req.user_role === USER_ROLES.API_ACCESS) {
        const subscriptionData: SubscriptionDto = req.body;
        const createSubscriptionData: Subscription = await this.subscriptionService.createSubscription(subscriptionData);

        res.status(201).json({ data: createSubscriptionData, message: 'created' });
      } else {
        throw new HttpException(403, 'Unauthorized access');
      }
    } catch (error) {
      next(error);
    }
  };
}

export default SubscriptionController;
