import { existsSync, mkdirSync } from 'fs';
import { join } from 'path';
import winston from 'winston';
import winstonDaily from 'winston-daily-rotate-file';
import { LOG_DIR } from '@config';

// ! I GET THIS ERROR WHEN USING LOG_DIR
/** 
node: internal / validators: 121
throw new ERR_INVALID_ARG_TYPE(name, 'string', value);
    ^

  TypeError[ERR_INVALID_ARG_TYPE]: The "path" argument must be of type string.Received undefined
    at new NodeError(node: internal / errors: 387: 5)
    at validateString(node: internal / validators: 121: 11)
    at join(node: path: 429: 7)
    at Object.<anonymous>(C: \Users\sduza\Desktop\MealDashProject\meal - dash\meal - dash - business\dist\utils\logger.js: 25: 31)
    at Module._compile(node: internal / modules / cjs / loader: 1126: 14)
    at Object.Module._extensions..js(node: internal / modules / cjs / loader: 1180: 10)
    at Module.load(node: internal / modules / cjs / loader: 1004: 32)
    at Function.Module._load(node: internal / modules / cjs / loader: 839: 12)
    at Module.require(node: internal / modules / cjs / loader: 1028: 19)
    at require(node: internal / modules / cjs / helpers: 102: 18) {
  code: 'ERR_INVALID_ARG_TYPE'
}
*/

// logs dir
// const logDir: string = join(__dirname, LOG_DIR);
const logDir: string = join(__dirname, "../../../logs");   


if (!existsSync(logDir)) {
  mkdirSync(logDir);
}

// Define log format
const logFormat = winston.format.printf(({ timestamp, level, message }) => `${timestamp} ${level}: ${message}`);

/*
 * Log Level
 * error: 0, warn: 1, info: 2, http: 3, verbose: 4, debug: 5, silly: 6
 */
const logger = winston.createLogger({
  format: winston.format.combine(
    winston.format.timestamp({
      format: 'YYYY-MM-DD HH:mm:ss',
    }),
    logFormat,
  ),
  transports: [
    // debug log setting
    new winstonDaily({
      level: 'debug',
      datePattern: 'YYYY-MM-DD',
      dirname: logDir + '/debug', // log file /logs/debug/*.log in save
      filename: `%DATE%.log`,
      maxFiles: 30, // 30 Days saved
      json: false,
      zippedArchive: true,
    }),
    // error log setting
    new winstonDaily({
      level: 'error',
      datePattern: 'YYYY-MM-DD',
      dirname: logDir + '/error', // log file /logs/error/*.log in save
      filename: `%DATE%.log`,
      maxFiles: 30, // 30 Days saved
      handleExceptions: true,
      json: false,
      zippedArchive: true,
    }),
  ],
});

logger.add(
  new winston.transports.Console({
    format: winston.format.combine(winston.format.splat(), winston.format.colorize()),
  }),
);

const stream = {
  write: (message: string) => {
    logger.info(message.substring(0, message.lastIndexOf('\n')));
  },
};

export { logger, stream };
