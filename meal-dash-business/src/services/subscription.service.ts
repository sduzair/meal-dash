import { EntityRepository, Repository } from 'typeorm';
import { SubscriptionDto } from '@dtos/subscriptions.dto';
import { SubscriptionEntity } from '@entities/subscription.entity';
import { HttpException } from '@exceptions/HttpException';
import { Subscription } from '@interfaces/subscription.interface';
import { isEmpty } from '@utils/util';

@EntityRepository()
class SubscriptionService extends Repository<SubscriptionEntity> {
  public async createSubscription(SubscriptionData: SubscriptionDto): Promise<Subscription> {
    console.log('--- services ---- ');
    if (isEmpty(SubscriptionData)) throw new HttpException(400, 'subscriptionData is empty');
    const createSubscriptionData: Subscription = await SubscriptionEntity.create({ ...SubscriptionData }).save();
    return createSubscriptionData;
  }
}

export default SubscriptionService;
