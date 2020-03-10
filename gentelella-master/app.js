const express = require('express');
const fileUpload = require('express-fileupload');
const server = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const md5 = require('md5');
const async = require("async");
var mysql = require('mysql');
var connection = require('./config/db');
var credentials = require('./config/credentials.json')
const TOKEN_PATH = './config/token.json';
const UPLOAD_PATH = './config/accredit.json';
const SCOPES = ['https://www.googleapis.com/auth/drive'];
const fs = require('fs');
const {
    google
} = require('googleapis');
const clipboardy = require('clipboardy');

// ---- URL PARSER
var url = require('url');
var session = require('express-session');
// ---- DEFINE SESSION
server.use(session({
    secret: 'ssshhhhh',
    resave: false,
    saveUninitialized: true
}));
server.use(express.static("public"));
const readline = require('readline');
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
    sess = req.session;
    if (!req.session.user) {
        console.log("No session")
        resp.redirect('/login');
    } else {
        var sql = "SELECT * FROM capstone.sysvalues;"
        connection.query(sql, function(err, result){
            if(result[0].inmaintenance == 0){
                resp.redirect('/home')
            }else{
                resp.redirect('/Maintenance')
            }
        })
    }
});

server.get('/debug', function (req, resp) {
    resp.render('./pages/register.ejs');
    console.log("Testing testing");
});

server.get('/debug1', function (req, resp) {
    resp.render('./pages/EditAccreditation.ejs');
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

/*server.get('/home', function (req, resp) {
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
});*/

server.get('/login', function (req, resp) {
    sess = req.session;
    if (req.session.user) {
        resp.redirect('/home');
    } else {
        var status = req.query.status
        switch (status) {
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

    }


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
        console.log("Check dbconfig.json for connection configurations or check if the MySQL Server is online")
        console.log("AccredIT Server is now offline")
        console.log("---------------------------------------------------------------------------------")
        console.log("\x1b[0m", "")
        serverclose.close();
    } else {
        console.log("\x1b[32m%s\x1b[0m", "AccredIT Server has successfully connected to the database")
        console.log("\x1b[32m%s\x1b[0m", "Server active at port", port);
        checktoken();
    }
});

function checktoken() {
    if (fs.existsSync('./config/token.json') && fs.existsSync('./config/accredit.json')) {
        console.log("\x1b[32m%s\x1b[0m", "Google Drive connection is configured");
    } else {
        console.log("\x1b[31m", "")
        console.log("---------------------------------------------------------------------------------")
        console.log("AccredIT Server is not configured to back up to Google Drive")
        console.log("Configure the Google Drive connection by following the instrictions")
        console.log("AccredIT Server is now offline")
        console.log("---------------------------------------------------------------------------------")
        console.log("\x1b[0m", "")
        driveinit();
        serverclose.close();
    }
}

function driveinit() {
    fs.readFile('./config/credentials.json', (err, content) => {
        if (err) return console.log('Error loading client secret file:', err);

        authorize(JSON.parse(content), listFiles);
    });
}

function authorize(credentials, callback) {
    const {
        client_secret,
        client_id,
        redirect_uris
    } = credentials.installed;
    const oAuth2Client = new google.auth.OAuth2(
        client_id, client_secret, redirect_uris[0]);

    // Check if we have previously stored a token.
    fs.readFile(TOKEN_PATH, (err, token) => {
        if (err) return getAccessToken(oAuth2Client, callback);
        oAuth2Client.setCredentials(JSON.parse(token));
        callback(oAuth2Client);
    });
}


function getAccessToken(oAuth2Client, callback) {
    const authUrl = oAuth2Client.generateAuthUrl({
        access_type: 'offline',
        scope: SCOPES,
    });
    console.log('Authorize Accred-IT server by visiting this url: ', authUrl);
    console.log('URL has been copied onto your clipboard')
    clipboardy.writeSync(authUrl);
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
    });
    rl.question('Enter the code from that page here: ', (code) => {
        rl.close();
        oAuth2Client.getToken(code, (err, token) => {
            if (err) return console.error('Error retrieving access token', err);
            oAuth2Client.setCredentials(token);
            // Store the token to disk for later program executions
            fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
                if (err) return console.error(err);
                console.log('Token stored to', TOKEN_PATH);
            });
            callback(oAuth2Client);
        });
    });
}


function listFiles(auth) {
    if (!fs.existsSync('./config/accredit.json')) {
        const drive = google.drive({
            version: 'v3',
            auth
        });
        var fileMetadata = {
            'name': 'AccredIT Uploads',
            'mimeType': 'application/vnd.google-apps.folder'
        };
        drive.files.create({
            resource: fileMetadata,
            fields: 'id'
        }, function (err, file) {
            if (err) {
                // Handle error
                console.error(err);
            } else {
                fs.writeFile(UPLOAD_PATH, JSON.stringify(file), (err) => {
                    if (err) return console.error(err);
                    console.log("Accredit Uploads folder created at connected account");
                    var port = process.env.PORT | 9090;
                    var serverclose = server.listen(port);
                    console.log("\x1b[32m%s\x1b[0m", "AccredIT Server has successfully connected to the database")
                    console.log("\x1b[32m%s\x1b[0m", "Server active at port", port);
                    checktoken();

                });
            }
        });
    } else {
        console.log("Drive connection has already been set up")
    }
}
