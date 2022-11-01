import nodemailer from 'nodemailer';
import { logger } from '@utils/logger';
import { SMTP_HOST, SMTP_PORT, SMTP_USERNAME, SMTP_PASSWORD } from '@config';


export default class MailService {
    private static instance: MailService;
    private transporter: nodemailer.Transporter;
    public SMTP_HOST: string;
    public SMTP_PORT:  number;
    private constructor() {
        this.transporter = nodemailer.createTransport({
            host: SMTP_HOST,
            port: parseInt(SMTP_PORT),
            secure:  false,
            auth: {
                user: process.env.SMTP_USERNAME,
                pass: process.env.SMTP_PASSWORD,
            },
        });
    }
    //INSTANCE CREATE FOR MAIL
    static getInstance() {
        if (!MailService.instance) {
            MailService.instance = new MailService();
        }
        return MailService.instance;
    }


    getMailOptions(){
        return {
            from: SMTP_USERNAME,
            to: 'Receiver Email Password',
            subject: 'Sending Email using Node.js',
            template: 'index',
            // attachments: [
            //   { filename: 'abc.jpg', path: path.resolve(__dirname, './image/abc.jpg')}
            // ]
          }
    }
    //SEND MAIL
    public async sendMail(
        email: string ,
    ) {
        return await this.transporter.sendMail({
            from: SMTP_USERNAME,
            to: email,
            subject: "Registration - Meal Dash",
            text: "Successfully Registered",
            html: "<strong>Hello world?</strong>",
            headers: { 'x-myheader': 'test header' }
          })
    }
    //VERIFY CONNECTION
    async verifyConnection() {
        return this.transporter.verify();
    }
    //CREATE TRANSPORTER
    getTransporter() {
        return this.transporter;
    }
}