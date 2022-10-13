import { NextFunction, Request, Response } from 'express';
import { SubscriptionDto } from '@/dtos/subscriptions.dto';
import { Subscription } from '@interfaces/subscription.interface';
import SubscriptionService from '@services/subscription.service';

class SubscriptionController {
  public subscriptionService = new SubscriptionService();

  public createSubscriptionPlan = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const subscriptionData: SubscriptionDto = req.body;
      const createSubscriptionData: Subscription = await this.subscriptionService.createSubscription(subscriptionData);

      res.status(201).json({ data: createSubscriptionData, message: 'created' });
    } catch (error) {
      next(error);
    }
  };
}

export default SubscriptionController;
