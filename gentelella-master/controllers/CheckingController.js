const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
var mysql = require('mysql');
var connection = require('../db');
// ---- URL PARSER
var url = require('url');
var session = require('express-session');
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));
// ----
var sess;
module.exports = {

    CheckingPage: function (req, resp) {
        resp.render('./pages/Checking.ejs');
        console.log("Checking");
    },

    CheckDetails: function (req, resp) {
        resp.render('./pages/CheckingDetailsPage.ejs');
        console.log("Checking");
    },

}
