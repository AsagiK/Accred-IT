const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const async = require("async");
var mysql = require('mysql');
var connection = require('./db');
// ---- URL PARSER
var url = require('url');
var session = require('express-session');
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));
// ---- kek
server.use(express.static("public"));

var routes = require('./routes');
server.use(express.json());
server.use(express.urlencoded({
    extended: true
}));
server.use(fileUpload({
    createParentPath: true,
    safeFileNames: true,
    preserveExtension: 10
}));
server.set('view engine', 'ejs');
//---------


server.get('/', function (req, resp) {

    resp.redirect('/RecommendationNonAjax');

    console.log("Testing testing");
});

server.get('/debug', function (req, resp) {
    resp.render('./pages/register.ejs');
    console.log("Testing testing");
});

server.get('/debug1', function (req, resp) {
    resp.render('./pages/ViewAllPlans.ejs');
    console.log("Testing testing");
});

server.get('/debug2', function (req, resp) {
    resp.render('./pages/NotAuthorizedPage.ejs');
    console.log("Testing testing");
});

server.get('/RegisterAdminPage', function (req, resp) {
    resp.render('./pages/RegisterAdminPage.ejs');
    console.log("Testing testing");
});

server.get('/home', function (req, resp) {
    sess = req.session;
    if (!req.session.user) {
        console.log("No session")
        resp.redirect('/login?status=0');
    } else {
        resp.render('./pages/home.ejs', {
            current_user: sess.user
        });
        console.log(sess.user);
    }
});

server.get('/login', function (req, resp) {
    var status = req.query.status
    switch (status) 
    {
        case "0":
            passData = {
                goodStatus: 0,
                msg: "You are not logged in"
            }
            resp.render('./pages/login.ejs', {
                notif: passData
            });
            break;
        case "1":
            passData = {
                goodStatus: 1,
                msg: "Incorrect Username or Password"
            }
            resp.render('./pages/login.ejs', {
                notif: passData
            });
            break;
        default:
            resp.render('./pages/login.ejs');
    }
    console.log("Testing testing");
});

server.use('/', routes);

server.get('/*', function (req, resp) {
    resp.render('./pages/ErrorPage.ejs');
    console.log("Testing testing");
});





const port = process.env.PORT | 9090;
var serverclose = server.listen(port);



connection.query("SHOW DATABASES LIKE 'capstone';", function (err, result, fields) {
    if (err) {
        console.log("\x1b[31m", "")
        console.log("---------------------------------------------------------------------------------")
        console.log("AccredIT Server could not initiate a connection to the database")
        console.log("Check db.js for connection configurations or check if the MySQL Server is online")
        console.log("AccredIT Server is now offline")
        console.log("---------------------------------------------------------------------------------")
        console.log("\x1b[0m", "")
        serverclose.close();
    } else {
        console.log("\x1b[32m%s\x1b[0m", "AccredIT Server has successfully connected to the database")
        console.log("\x1b[32m%s\x1b[0m", "Server active at port", port);
    }
});
