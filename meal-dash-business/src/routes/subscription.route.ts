import { Router } from 'express';
import SubscriptionController from '@controllers/subscription.controller';
import { SubscriptionDto } from '@/dtos/subscriptions.dto';
import { Routes } from '@interfaces/routes.interface';
import validationMiddleware from '@middlewares/validation.middleware';
import authMiddleware from '@/middlewares/auth.middleware';

// SubscriptionRoute class to handle all the routes for subscriptions
class SubscriptionRoute implements Routes {
  public path = '/subscription';
  public router = Router();
  public subscriptionController = new SubscriptionController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    console.log('--- routes ---- ');
    this.router.post(`${this.path}`, authMiddleware, validationMiddleware(SubscriptionDto, 'body'), this.subscriptionController.createSubscriptionPlan);
  }
}

export default SubscriptionRoute;
