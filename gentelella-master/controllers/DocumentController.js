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
const TOKEN_PATH = 'token.json';
var mime = require('mime-types')

var sess
module.exports = {

    UploadDocument: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            resp.render('./pages/UploadDocument.ejs', {
                current_user: sess.user
            });
        }
    },

    SendDocument: function (req, resp) {
        var name = req.body.DocName;
        var filename = req.files.DocFile.name;
        var path = 'uploads/' + req.files.DocFile.name
        var desc = req.body.DocDesc;
        var point = filename.lastIndexOf(".");
        var ext = filename.substr(point);
        var fileMetadata = {
            'name': req.files.DocFile.name,
            'description': req.body.DocDesc
        };
        var media;
        let uploadedimg = req.files.DocFile;
        uploadedimg.mv('public/uploads/' + req.files.DocFile.name, function (err) {
            if (err) return console.log(err);
            else console.log("File uploaded");
        })
        var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`) VALUES (? , ? , ?, ?);"
        var values = [name, path, desc, ext];
        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            if (result) {
                console.log("Record Inserted");
                resp.redirect('/UploadDocument');
                media = {
                    mimeType: mime.lookup('public/uploads/' + req.files.DocFile.name),
                    body: fs.createReadStream('public/uploads/' + req.files.DocFile.name)
                };
                uploadfile();
            }
        });
        function uploadfile() {
            fs.readFile('credentials.json', (err, content) => {
                if (err) return console.log('Error loading client secret file:', err);
                authorize(JSON.parse(content), uploadtodrive);
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

            fs.readFile(TOKEN_PATH, (err, token) => {
                if (err) return getAccessToken(oAuth2Client, callback);
                oAuth2Client.setCredentials(JSON.parse(token));
                callback(oAuth2Client);
            });
        }
        function uploadtodrive(auth) {
            const drive = google.drive({
                version: 'v3',
                auth
            });
            drive.files.create({
                resource: fileMetadata,
                media: media,
                fields: 'id'
            }, function (err, file) {
                if (err) {
                    console.log("File was not uploaded")
                } else {
                    sql = "UPDATE `capstone`.`documents` SET `InDrive` = '1' WHERE (`Document_Route` = ?);"
                    values = 'uploads/' + req.files.DocFile.name;
                    connection.query(sql, values, function (err, result) {
                        if (err) throw err;
                        if (result) {
                            console.log(result);
                            console.log(req.files.DocFile.name + " Uploaded to Google Drive")
                        }
                    });
                }
            });
        }
    },

    ViewDocument: function (req, resp) {
        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            connection.query("SELECT * FROM capstone.documents ;", function (err, results, fields) {
                if (err) throw err;
                resp.render('./pages/ViewDocument.ejs', {
                    data: results,
                    current_user: sess.user
                });
                console.log(results);
            });
            console.log("ViewDocument");
        }
    },

}
