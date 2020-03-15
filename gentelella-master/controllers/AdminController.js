const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const fs = require('fs');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const async = require("async");
var mysql = require('mysql');
var connection = require('../config/db');
try {
    var TOKEN_PATH = './config/token.json'
    var UPLOAD_PATH = JSON.parse(fs.readFileSync('./config/accredit.json', 'utf8'));
} catch (e) {

}

var dir = 'public/SQLDump';

if (!fs.existsSync(dir)){
    fs.mkdirSync(dir);
}

const disk = require('check-disk-space')
const mysqldump = require('mysqldump')
const dbconfig = JSON.parse(fs.readFileSync('./config/dbconfig.json', 'utf8'));

var schedule = require('node-schedule');

// ---- URL PARSER
var url = require('url');
var session = require('express-session');
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));
// ---- GOOGLE API
const readline = require('readline');
const {
    google
} = require('googleapis');

server.use(fileUpload({
    createParentPath: true,
    safeFileNames: true,
    preserveExtension: 10
}));
const SCOPES = ['https://www.googleapis.com/auth/drive'];
var mime = require('mime-types');
var Notif = require('../controllers/NotifController')
var sess


module.exports = {

    SystemMaintenance: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else if (req.session.user[0].Role == 1) {
            var sql = "SELECT * FROM capstone.roles; SELECT * FROM capstone.users; SELECT * FROM capstone.activity_outputs; SELECT * FROM capstone.pending_outputs; "
            connection.query(sql, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/MaintenancePage.ejs', {
                    data: results[0],
                    current_user: sess.user
                });

                console.log("SYSTEM MAINTENANCE PAGE");



            });
        } else {
            resp.redirect('/home')
        }
    },

    GenerateBackup: function (req, resp) {
        async function getBackup() {
            const result = await mysqldump({
                connection: {
                    host: dbconfig.host,
                    user: dbconfig.user,
                    password: dbconfig.password,
                    database: dbconfig.schema,
                },
                dump: {
                    schema: {
                        table: {
                            dropIfExist: true
                        }
                    },
                    data: {
                        maxRowsPerInsertStatement: 1000,
                    }
                },
                dumpToFile: './public/SQLDump/AccredITdump.sql',
            });
        }

        getBackup().then((result) => {
            console.log("Backup Generated")
            resp.send("OK") // 5
        })

    },

    ShutSystem: function (req, resp) {
        sess = req.session;
        var sessionchecksql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sessionchecksql, function (err, result) {
            if (result[0].inmaintenance == 1) {
                sess.destroy();
                console.log("session destroyed");
            } else {
                //console.log("session not destroyed");
            }
        })
        console.log(req.body)
        var UpDate = req.body.UpDate;
        var UpTime = req.body.UpTime;
        var UpDateTime = UpDate + "T" + UpTime + ":00"
        var UpDateSchedule = new Date(UpDateTime);
        console.log(UpDateSchedule)

        var bringsystemback = schedule.scheduleJob(UpDateSchedule, function () {
            var rebootsql = "UPDATE `capstone`.`sysvalues` SET `inmaintenance` = '0' WHERE (`idsysvalues` = '1');"
            connection.query(rebootsql, function (err, result) {
                if (result) {
                    console.log("System is back")
                }
            })
        });

        var sql = "UPDATE `capstone`.`sysvalues` SET `inmaintenance` = '1' WHERE (`idsysvalues` = '1');"
        connection.query(sql, function (err, result) {
            if (result) {
                console.log("System is down")
                setTimeout(function () {
                    resp.redirect("/Maintenance")
                }, 8000)
            }
        })


    },

}
