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

const bcrypt = require('bcrypt');
const saltRounds = 10;

// ----
var sess;
module.exports = {

    Register: function (req, resp) {
        // console.log(req.body.username);
        //  console.log(req.body.password);
        var user = req.body.username;
        var pass = req.body.password;
        var fname = req.body.username;
        var lname = req.body.username;
        var email = "debug@debug.com";
        var role = "1";
        var contact = "99999999999"


        bcrypt.hash(pass, saltRounds, function (err, hash) {

            var sql = "INSERT INTO `capstone`.`users` (`User_First`, `User_Last`, `email_address`, `Role`, `ContactNo`, `username`, `passwd`) VALUES (?, ?, ?, ?, ?, ?, ?);"
            var values = [fname, lname, email, role, contact, user, hash];

            connection.query(sql, values, function (err, result) {
                if (err) {
                    console.log("Username already exists");
                    resp.redirect('/debug');
                } else {
                    console.log("Admin Created");
                    resp.redirect('/login');
                }
            });

        });
    },

    Register2: function (req, resp) {
        // console.log(req.body.username);
        //  console.log(req.body.password);
        var user = req.body.username;
        var pass = req.body.password;
        var fname = req.body.username;
        var lname = req.body.username;
        var email = req.body.email;
        var contact = req.body.contact;


        bcrypt.hash(pass, saltRounds, function (err, hash) {

            var sql = "INSERT INTO `capstone`.`users` (`User_First`, `User_Last`, `email_address`, `ContactNo`, `username`, `passwd`) VALUES (?, ?, ?, ?, ?, ?);"
            var values = [fname, lname, email, contact, user, hash];

            connection.query(sql, values, function (err, result) {
                if (err) {
                    console.log("Username already exists");
                    resp.redirect('/debug');
                } else {
                    console.log("User Created");
                    resp.redirect('/login');
                }
            });

        });
    },


    Login: function (req, resp) {
        sess = req.session;
        var user = req.body.username;
        var pass = req.body.password;
        console.log(user);

        var sql = "SELECT users.passwd FROM capstone.users where binary username = ?;"
        var values = [user];

        connection.query(sql, values, function (err, result, fields) {
            if (result.length < 1) {
                console.log("user not found")
                resp.redirect('/login?status=1');
            } else {

                bcrypt.compare(pass, result[0].passwd, function (err, res) {
                    console.log(res);
                    if (res == true) {
                        console.log("User validated");


                        var sessql = "SELECT users.User_ID, users.User_First, users.User_Last, users.email_address, users.role, users.group, users.ContactNo, users.username FROM capstone.users where binary username = ?"
                        var sesvalues = [user];

                        connection.query(sessql, sesvalues, function (err2, result2, fields2) {
                            if (err) throw err;
                            sess.user = result2;
                            resp.redirect('/home');
                        });




                    } else {
                        resp.redirect('/login?status=1');
                        console.log("Invalid user");
                    }

                });
            }

        });

    },

    Logout: function (req, resp) {
        req.session.destroy();
        resp.redirect('/login');
    }

}
