import mongoose from "mongoose";
import morgan from "morgan";
import Express from "express";
import { pick } from "lodash"; 
import moment from "moment";


const app = Express();
app.use(morgan("tiny"));
app.use(Express.json());
app.use(Express.urlencoded({extended:true}));



mongoose.connect("mongodb://localhost/Meal_Dash");
let PORT:number|string = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`connection has been created on ${PORT}`);
})