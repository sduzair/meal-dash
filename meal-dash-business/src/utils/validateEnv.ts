import { cleanEnv, port, str } from 'envalid';

// This function validates the environment variables
const validateEnv = () => {
  cleanEnv(process.env, {
    NODE_ENV: str(),
    PORT: port(),
  });
};

export default validateEnv;
