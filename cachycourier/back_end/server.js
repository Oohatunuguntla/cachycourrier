var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const session = require('express-session');

/** Configured Passport */
const passport = require('./config/passport');

const app=express();
const morgan=require("morgan");
const bodyparser=require("body-parser");
const mongoose=require("mongoose");
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var notificationsRouter=require('./routes/notification');
var statistcsRouter=require('./routes/statistics')
var authRouter = require('./routes/auth');
var addorderRouter=require('./routes/addorder');

const dotenv = require("dotenv");
dotenv.config()
const uri = `${process.env.DB_key}`;
mongoose.connect(uri).then(
  _ => {
    console.info('Database connection stablished');
  },
  error => {
    console.error('Database connection failed:', error);
    throw new Error('Could not connect to the database');
  }
);

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
app.use(morgan('dev'));
app.use(bodyparser.urlencoded({extended:false}));
app.use(bodyparser.json());
app.use(express.static(__dirname+'/views'));
app.use(express.static(__dirname+'/public'));
app.use(cookieParser());


app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');
app.use(session({
    secret: 'secret key',
    saveUninitialized: false,
    resave: false
  }))
  
  /** Flash messages */
  app.use(require('connect-flash')());
  
  /** Initialize passport and session */
  app.use(passport.initialize());
  app.use(passport.session());
  app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/notifications',notificationsRouter);
app.use('/stats',statistcsRouter)
app.use('/addorder',addorderRouter);

/** Pass configured passport to auth router */
app.use('/auth', authRouter(passport));


const port = process.env.PORT || 5000;

app.listen(port, () => {
    console.log(`Backend is running on port ${port}`);
})