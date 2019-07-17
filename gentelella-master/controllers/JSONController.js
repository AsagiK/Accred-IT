const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const async = require("async");
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

    AssignGroupJSON: function (req, resp) {
        var UID = req.body.table;
        UID = JSON.parse(UID);
        
        async.forEachOf(UID, function(value, key, callback){
            var gid = UID[key]["Group ID"];
            var uid = UID[key]["User ID"];
            var sql = "Update capstone.users set users.Group = ? where users.User_ID = ?; INSERT INTO `capstone`.`groupdetails` (`Groupdetails_ID`, `Groupdetails_UserID`) VALUES (? , ? ); ";
            var values = [gid, uid, gid, uid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if(result){
                    callback();
                }
            });
        }, function(err){
            if (err) {
                    console.log("Failed");
                    resp.send("Not OK")
                } else {
                    console.log("Passed");
                    resp.send("OK");
                }
        })
    },


    ViewPlanTest: function (req, resp) {
        const submit = require('../public/JSONs/viewplantest.json');
        console.log(submit);
        resp.json(submit);
    },

}
