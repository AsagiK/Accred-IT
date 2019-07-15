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

server.use(fileUpload({
    createParentPath: true,
    safeFileNames: true,
    preserveExtension: 10
}));

var sess
module.exports = {

    UploadDocument: function (req, resp) {

        sess = req.session;
        if (!req.session.user) {
            console.log("No session")
            resp.redirect('/login');
        } else {
            resp.render('./pages/UploadDocument.ejs', {current_user: sess.user});
            
        }
    },

    SendDocument: function (req, resp) {
        var name = req.body.DocName;
        var filename = req.files.DocFile.name;
        var path = 'uploads/' + req.files.DocFile.name
        var desc = req.body.DocDesc;

        var point = filename.lastIndexOf(".");

        var ext = filename.substr(point);

        console.log(req.files.DocFile.md5);


        let uploadedimg = req.files.DocFile;
        uploadedimg.mv('public/uploads/' + req.files.DocFile.name, function (err) {
            if (err) return console.log(err);
            else console.log("File uploaded");
        })

        var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`, `Document_Ext`) VALUES (? , ? , ?, ?);"
        var values = [name, path, desc, ext];

        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");
            resp.redirect('/UploadDocument');
        });


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
                data: results, current_user: sess.user
            });
            console.log(results);
        });
        console.log("ViewDocument");
    }
    },

}
