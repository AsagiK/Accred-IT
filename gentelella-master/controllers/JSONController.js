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
        async.forEachOf(UID, function (value, key, callback) {
            var gid = UID[key]["Group ID"];
            var uid = UID[key]["User ID"];
            var sql = "Update capstone.users set users.Group = ? where users.User_ID = ?; INSERT INTO `capstone`.`groupdetails` (`Groupdetails_ID`, `Groupdetails_UserID`) VALUES (? , ? ); ";
            var values = [gid, uid, gid, uid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })
    },

    AssignTaskJSON: function (req, resp) {
        var UID = req.body.table;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var pid = UID[key]["Plan ID"];
            var uid = UID[key]["User ID"];
            var sql = "INSERT INTO `capstone`.`plandetails` (`Plan_ID`, `Member_ID`) VALUES (? , ?) ";
            var values = [pid, uid];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })

    },

    AddGradesJSON: function (req, resp) {
        var UID = req.body.table;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var acc = UID[key]["Accreditation"];
            var code = UID[key]["Code"];
            var rank = UID[key]["Rank"];
            var sql = "INSERT INTO `capstone`.`grades` (`Rank`, `Code`, `Accreditation_ID`) VALUES (?, ?, ?);";
            var values = [rank, code, acc];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                var acc2 = UID[0]["Accreditation"];
                var sql2 = "UPDATE `capstone`.`accreditation` SET `gradesset` = '1' WHERE (`accreditation_ID` = ?);"
                var values2 = [acc2];
                connection.query(sql2, values2, function (err2, result2) {
                    if (err2) callback(err);
                    if (result2) {
                        console.log("------Grades locked");
                    }
                });
                resp.send("OK");
            }
        })
    },

    AddActivitiesJSON: function (req, resp) {
        var UID = req.body.table;
        var MID = req.body.mid;
        UID = JSON.parse(UID);
        console.log(UID);
        async.forEachOf(UID, function (value, key, callback) {
            var an = UID[key]["Activity Name"];
            var tar = UID[key]["Target"];
            var code = UID[key]["Code"];
            var desc = UID[key]["Description"];
            var sql = "INSERT INTO `capstone`.`approved_activities` (`activity_name`, `target`, `code`, `description`, `measurement_ID`) VALUES (?, ?, ?, ?, ?);";
            var values = [an, tar, code, desc, MID];
            connection.query(sql, values, function (err, result) {
                if (err) callback(err);
                if (result) {
                    callback();
                }
            });
        }, function (err) {
            if (err) {
                console.log("Failed");
                resp.send("Not OK")
            } else {
                console.log("Passed");
                resp.send("OK");
            }
        })

    },

    

}
