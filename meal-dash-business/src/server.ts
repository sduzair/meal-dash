import App from '@/app';
import AuthRoute from '@routes/auth.route';
import IndexRoute from '@routes/index.route';
import UsersRoute from '@routes/users.route';
import validateEnv from '@utils/validateEnv';
import SubscriptionRoute from './routes/subscription.route';
import MealRoute from './routes/meal.route';
import MealPlanRoute from './routes/mealplan.route';
validateEnv();

const app = new App([new IndexRoute(), new UsersRoute(), new AuthRoute(), new SubscriptionRoute(), new MealRoute(), new MealPlanRoute()]);

app.listen();
