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
    secret: 'ssshhhhh'
}));
// ----
var sess;
module.exports = {

    sess = req.session;
    if (!req.session.user) {
        console.log("No session")
        resp.redirect('/login?status=0');
    } else {
        {
            current_user: sess.user
        }
    }

}
