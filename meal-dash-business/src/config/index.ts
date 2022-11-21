/* eslint-disable prettier/prettier */
import { config } from 'dotenv';
config({ path: `.env.${process.env.NODE_ENV || 'development'}.local` });

export const CREDENTIALS = process.env.CREDENTIALS === 'true';
export const { UPLOAD_PATH, NODE_ENV, PORT, DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_DATABASE, SECRET_KEY, LOG_FORMAT, LOG_DIR, ORIGIN, SMTP_HOST, SMTP_PORT, SMTP_USERNAME, SMTP_PASSWORD, GOOGLE_API_KEY} = process.env;
