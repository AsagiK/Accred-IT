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


const disk = require('check-disk-space')
const mysqldump = require('mysqldump')
const dbconfig = JSON.parse(fs.readFileSync('./config/dbconfig.json', 'utf8'));


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
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login?status=0');
        } else if(req.session.user[0].Role == 1){
            var sql = "SELECT * FROM capstone.roles; SELECT * FROM capstone.users; SELECT * FROM capstone.activity_outputs; SELECT * FROM capstone.pending_outputs; "
            connection.query(sql, function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/MaintenancePage.ejs', {
                    data: results[0],
                    current_user: sess.user
                });

                console.log("SYSTEM MAINTENANCE PAGE");



            });
        }else{
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
            console.log("Backup Generated") // 5
        })

    },

}
