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

module.exports = {

    UploadDocument: function (req, resp) {
        resp.render('./pages/UploadDocument.ejs');
        console.log("Testing testing");
    },

    SendDocument: function (req, resp) {
        var name = req.body.DocName;
        var filename = req.files.DocFile.name;
        var path = 'public/uploads/' + req.files.DocFile.name
        var desc = req.body.DocDesc;
        console.log(path);

        let uploadedimg = req.files.DocFile;
        uploadedimg.mv('public/uploads/' + req.files.DocFile.name, function (err) {
            if (err) return console.log(err);
            else console.log("File uploaded");
        })

        var sql = "INSERT INTO `capstone`.`documents` (`Document_Name`, `Document_Route`, `Document_Desc`) VALUES (? , ? , ?);"
        var values = [name, path, desc];

        connection.query(sql, values, function (err, result) {
            if (err) throw err;
            console.log("Record Inserted");

        });


        resp.redirect('/UploadDocument');

    },

}